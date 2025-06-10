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

    let container: NSPersistentContainer
    let context: NSManagedObjectContext

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MedimoModel")

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
        let result = await cloudKitManager.fetchAllTerms()
        var terms: [TermDTO] = []

        switch result {
        case let .success(loadedTerms):
            terms = loadedTerms

            // 백그라운드 컨텍스트에서 일괄 처리
            await container.performBackgroundTask { [weak self] context in
                guard self != nil else { return }
                for term in terms {
                    let fetchRequest: NSFetchRequest<Term> = Term.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %d", term.id)
                    fetchRequest.fetchLimit = 1

                    if let _ = try? context.fetch(fetchRequest).first {
                        continue
                    }

                    let termEntity = Term(context: context)
                    termEntity.id = Int64(term.id)
                    termEntity.spelling = term.spelling
                    termEntity.meaning = term.meaning
                    termEntity.explanation = term.explanation
                    if term.abbreviation == "-" {
                        termEntity.abbreviation = ""
                    } else {
                        termEntity.abbreviation = term.abbreviation
                    }
                }
                do {
                    try context.save()
                    print("✏️ Fetched Terms: \(terms.count)")
                } catch {
                    print("❌ Failed to save Core Data: \(error)")
                }
            }

        case let .failure(error):
            print("Error fetching terms: \(error)")
        }
    }

    func initializeMorphemeData() async {
        let result = await cloudKitManager.fetchAllMorphemes()
        var morphemes: [MorphemeDTO] = []

        switch result {
        case let .success(loadedMorphemes):
            morphemes = loadedMorphemes

            // 백그라운드 컨텍스트에서 일괄 처리
            await container.performBackgroundTask { [weak self] context in
                guard self != nil else { return }
                for morpheme in morphemes {
                    let fetchRequest: NSFetchRequest<Morpheme> = Morpheme.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == %d", morpheme.id)
                    fetchRequest.fetchLimit = 1

                    if let _ = try? context.fetch(fetchRequest).first {
                        continue
                    }

                    let morphemeEntity = Morpheme(context: context)
                    morphemeEntity.id = Int64(morpheme.id)
                    morphemeEntity.spelling = morpheme.spelling
                    morphemeEntity.meaning = morpheme.meaning
                }
                do {
                    try context.save()
                    print("✏️ Fetched Morphemes: \(morphemes.count)")
                } catch {
                    print("❌ Failed to save Core Data: \(error)")
                }
            }

        case let .failure(error):
            print("Error fetching terms: \(error)")
        }
    }

    func initializeTermMorphemeRelationshipData() async {
        let result = await cloudKitManager.fetchAllTermMorphemeRelationships()
        var relationships: [TermMorphemeRelationshipDTO] = []

        switch result {
        case let .success(loadedRelationships):
            relationships = loadedRelationships

            // 백그라운드 컨텍스트에서 일괄 처리
            await container.performBackgroundTask { [weak self] context in
                guard self != nil else { return }
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
                do {
                    try context.save()
                    print("✏️ Fetched Relationships: \(relationships.count)")
                } catch {
                    print("❌ Failed to save Core Data: \(error)")
                }
            }

        case let .failure(error):
            print("Error fetching relationships: \(error)")
        }
    }

    func initializeGlossaryData() async {
        let result = await cloudKitManager.fetchAllGlossaries()
        var glossaries: [GlossaryDTO] = []

        switch result {
        case let .success(loadedGlossaries):
            glossaries = loadedGlossaries

            // 백그라운드 컨텍스트에서 일괄 처리
            await container.performBackgroundTask { [weak self] context in
                guard self != nil else { return }

                // User 데이터 불러오기
                let userFetchRequest: NSFetchRequest<User> = User.fetchRequest()
                userFetchRequest.fetchLimit = 1
                let user = (try? context.fetch(userFetchRequest).first) ?? User(context: context)

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

                    let glossaryProgressEntity = GlossaryProgress(context: context)
                    glossaryProgressEntity.glossary = glossaryEntity
                    glossaryProgressEntity.studiedCount = 0
                    glossaryProgressEntity.user = user
                    user.addToProgresses(glossaryProgressEntity)

                    var termsToAdd: [Term] = []
                    for termId in glossary.terms {
                        let termFetch: NSFetchRequest<Term> = Term.fetchRequest()
                        termFetch.predicate = NSPredicate(format: "id == %d", termId)
                        termFetch.fetchLimit = 1

                        if let term = try? context.fetch(termFetch).first {
                            termsToAdd.append(term)

                            // TermStudyData 생성 + 관계 설정
                            let termStudyData = TermStudyData(context: context)
                            termStudyData.id = UUID()
                            termStudyData.easeFactor = 2.5
                            termStudyData.interval = 0
                            termStudyData.lastReviewedAt = nil
                            termStudyData.nextReviewAt = nil
                            termStudyData.reviewCount = 0
                            termStudyData.status = "notStarted" // 초기 상태 설정
                            termStudyData.glossary = glossaryEntity
                            termStudyData.term = term
                            termStudyData.user = user

                            user.addToTermStudyData(termStudyData) // User와 관계 설정
                        }
                    }
                    // 반복문 종료 후 한 번에 관계 연결
                    for term in termsToAdd {
                        glossaryEntity.addToTerms(term)
                    }

                    do {
                        try context.save()
                        print("✏️ Fetched Glossaries: \(glossaries.count)")
                    } catch {
                        print("❌ Failed to save Core Data: \(error)")
                    }
                }
            }

        case let .failure(error):
            print("Error fetching terms: \(error)")
        }
    }

    func initializeUserData() async {
        let user = User(context: context)
        user.id = UUID()
        user.currentStreak = 0
        user.longestStreak = 0
        user.totalLearningTerms = 0

        // TODO: - 나중에 삭제하기
        // 테스트용 DateInfo 5개 생성
        for i in 0 ..< 5 {
            let dateInfo = DateInfo(context: context)
            if i % 2 == 0 {
                dateInfo.date = Calendar.current.date(byAdding: .day, value: -i, to: Date())
                dateInfo.studyCount = Int32(10 + i)
                dateInfo.reviewCount = Int32(10 + i)
            } else {
                dateInfo.date = Calendar.current.date(byAdding: .day, value: -i, to: Date())
                dateInfo.studyCount = Int32(10 + i)
                dateInfo.reviewCount = 0
            }

            user.addToDateInfos(dateInfo)
        }

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
        let morphemeDict = morphemes.reduce(into: [Int64: Morpheme]()) { dict, morpheme in
            dict[morpheme.id] = morpheme
        }

        for term in terms {
            // order 순서대로 morphemeId 추출
            let morphemeIds = relationships
                .filter { $0.termId == term.id }
                .sorted { $0.order < $1.order }
                .map { $0.morphemeId }

            // 순서대로 morpheme 객체 배열 생성
            let morphemesToAdd = morphemeIds.compactMap { morphemeDict[$0] }

            // TODO: - 삭제할 것. DEBUG
            if term.id > 5, term.id < 13 {
                print("Morphemes for term \(term.id):\n")
                for morpheme in morphemesToAdd {
                    print("  - \(morpheme.id) -> \(morpheme.spelling ?? "Unknown"): \(morpheme.meaning ?? "No meaning")")
                }
            }

            // Core Data 모델에서 morphemes가 NSOrderedSet이면 아래처럼 설정
            term.morphemes = NSOrderedSet(array: morphemesToAdd)
        }

        save()
    }

    func initialize() async -> Bool {
        // 병렬로 실행 가능한 작업
        async let termTask: () = initializeTermData()
        async let morphemeTask: () = initializeMorphemeData()
        async let relationshipTask: () = initializeTermMorphemeRelationshipData()
        async let userTask: () = initializeUserData()

//        // 위 5개가 모두 끝난 후 실행 (의존성 있음)
        _ = await (termTask, morphemeTask, relationshipTask, userTask)
//        await initializeTermData()
//        await initializeMorphemeData()
//        await initializeTermMorphemeRelationshipData()
//        await initializeUserData()

        await linkMorphemesToTerms()
        await initializeGlossaryData()

        return true
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
