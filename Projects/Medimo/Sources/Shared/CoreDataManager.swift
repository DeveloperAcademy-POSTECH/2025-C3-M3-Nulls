//
//  CoreDataManager.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//

import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let cloudKitManager = CloudKitManager.shared

    let container: NSPersistentCloudKitContainer
    let context: NSManagedObjectContext

    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "MedimoModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error {
                print("Error loading Core data: \(error)")
            }
        })
        context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

// MARK: - CRUD 관련

extension CoreDataManager {
    func save() {
        do {
            try context.save()
            print("📝 Successfully saved Core Data.")
        } catch {
            print("❌ Failed to save Core Data: \(error)")
        }
    }
}

// MARK: - Initialization 관련

extension CoreDataManager {
    func needsInitialCloudKitFetch(context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.fetchLimit = 1
        let count = (try? context.count(for: fetchRequest)) ?? 0
        return count == 0
    }

    func initializeTermData() async {
        var terms: [TermDTO] = []

        let result = await cloudKitManager.fetchAllTerms()
        switch result {
        case let .success(loadedTerms):
            terms = loadedTerms

        case let .failure(error):
            print("Error fetching terms: \(error)")
        }

        for term in terms {
            let fetchRequest: NSFetchRequest<Term> = Term.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", term.id)
            fetchRequest.fetchLimit = 1

            // 이미 존재하면 continue
            if let _ = try? context.fetch(fetchRequest).first {
                continue
            }

            let termEntity = Term(context: context)
            termEntity.id = Int64(term.id)
            termEntity.spelling = term.spelling
            termEntity.meaning = term.meaning
            termEntity.explanation = term.explanation
            termEntity.abbreviation = term.abbreviation
        } // Task

        save()

        print("✏️ Fetched Terms: \(terms.count)")
    }

    func initializeMorphemeData() async {
        var morphemes: [MorphemeDTO] = []

        Task {
            let result = await cloudKitManager.fetchAllMorphemes()
            switch result {
            case let .success(loadedMorphemes):
                morphemes = loadedMorphemes

            case let .failure(error):
                print("Error fetching terms: \(error)")
            }

            for morpheme in morphemes {
                let fetchRequest: NSFetchRequest<Morpheme> = Morpheme.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", morpheme.id)
                fetchRequest.fetchLimit = 1

                // 이미 존재하면 continue
                if let _ = try? context.fetch(fetchRequest).first {
                    continue
                }

                let morphemeEntity = Morpheme(context: context)
                morphemeEntity.id = Int64(morpheme.id)
                morphemeEntity.spelling = morpheme.spelling
                morphemeEntity.meaning = morpheme.meaning
            }
            save()

            print("✏️ Fetched Morphemes: \(morphemes.count)")
        } // Task
    }

    func initializeTermMorphemeRelationshipData() async {
        var relationships: [TermMorphemeRelationshipDTO] = []

        let result = await cloudKitManager.fetchAllTermMorphemeRelationships()
        switch result {
        case let .success(loadedRelationships):
            relationships = loadedRelationships

        case let .failure(error):
            print("Error fetching relationships: \(error)")
        }

        for relationship in relationships {
            let fetchRequest: NSFetchRequest<TermMorphemeRelationship> = TermMorphemeRelationship.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "termId == %d AND morphemeId == %d",
                relationship.termId, relationship.morphemeId
            )
            fetchRequest.fetchLimit = 1

            // 이미 존재하면 continue
            if let _ = try? context.fetch(fetchRequest).first {
                continue
            }

            let relationshipEntity = TermMorphemeRelationship(context: context)
            relationshipEntity.termId = Int64(relationship.termId)
            relationshipEntity.morphemeId = Int64(relationship.morphemeId)
            relationshipEntity.order = Int16(relationship.order)
        }

        save()
        print("✏️ Fetched Relationships: \(relationships.count)")
    }

    func initializeGlossaryData() async {
        var glossaries: [GlossaryDTO] = []

        Task {
            let result = await cloudKitManager.fetchAllGlossaries()
            switch result {
            case let .success(loadedGlossaries):
                glossaries = loadedGlossaries

            case let .failure(error):
                print("Error fetching terms: \(error)")
            }

            for glossary in glossaries {
                let fetchRequest: NSFetchRequest<Glossary> = Glossary.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", glossary.id)
                fetchRequest.fetchLimit = 1

                // 이미 존재하면 continue
                if let _ = try? context.fetch(fetchRequest).first {
                    continue
                }

                let glossaryEntity = Glossary(context: context)
                glossaryEntity.id = Int64(glossary.id)
                glossaryEntity.category = glossary.category
                glossaryEntity.title = glossary.title

                for termId in glossary.terms {
                    let fetchRequest: NSFetchRequest<Term> = Term.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %d", termId)
                    fetchRequest.fetchLimit = 1

                    if let term = try? context.fetch(fetchRequest).first {
                        glossaryEntity.addToTerms(term)
                    }
                }
            }
            save()
            print("✏️ Fetched Glossaries: \(glossaries.count)")
        } // Task
    }

    func initializeUserData() async {
        let user = User(context: context)
        user.id = UUID()
        user.currentStreak = 0
        user.longestStreak = 0
        user.totalLearningTerms = 0

        save()
    }

    func linkMorphemesToTerms() async {
        let termFetchRequest: NSFetchRequest<Term> = Term.fetchRequest()
        let terms = (try? context.fetch(termFetchRequest)) ?? []

        let morphemeFetchRequest: NSFetchRequest<Morpheme> = Morpheme.fetchRequest()
        let morphemes = (try? context.fetch(morphemeFetchRequest)) ?? []

        let relationshipFetchRequest: NSFetchRequest<TermMorphemeRelationship> = TermMorphemeRelationship.fetchRequest()
        let relationships = (try? context.fetch(relationshipFetchRequest)) ?? []

        // morphemeId로 Morpheme를 빠르게 찾기 위한 딕셔너리 생성
        let morphemeDict = Dictionary(uniqueKeysWithValues: morphemes.map { ($0.id, $0) })

        func relatedMorphemeIds(for term: Term) -> [Int64] {
            relationships
                .filter { $0.termId == term.id }
                .sorted { $0.order < $1.order }
                .map { $0.morphemeId }
        }

        for term in terms {
            let morphemeIds = relatedMorphemeIds(for: term)
            for morphemeId in morphemeIds {
                // morpheme.id가 nil이 아닌 경우만 추가
                if let morpheme = morphemeDict[morphemeId] {
                    term.addToMorphemes(morpheme)
                }
            }
        }

        save()
    }

    func initialize() async {
        // 초기 데이터 삽입
        await initializeTermData()
        await initializeMorphemeData()
        await initializeTermMorphemeRelationshipData()
        await initializeGlossaryData()
        await initializeUserData()
        await linkMorphemesToTerms()
    }
}

// MARK: - Preview 관련

extension CoreDataManager {
    // 역할: 이 코드는 SwiftUI의 미리보기 기능에서 사용할 수 있는 PersistenceController의 인스턴스를 제공합니다.
    @MainActor
    static let preview: CoreDataManager = {
        let result = CoreDataManager(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0 ..< 10 {
            let newItem = Term(context: viewContext)
            newItem.id = Int64(i)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
