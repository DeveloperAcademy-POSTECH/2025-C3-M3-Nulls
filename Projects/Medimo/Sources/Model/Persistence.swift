//
//  Persistence.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

//    // 미리보기 용 임시 인메모리 컨텍스트 (PreviewProvider에서 사용)
//    static var preview: PersistenceController = {
//        let controller = PersistenceController(inMemory: true)
//        let context = controller.container.viewContext
//
//        // 예시 데이터 추가
//        var mockGlossarys: [Glossary] = []
//        var mockTerms: [Term] = []
//        var mockMorphemes: [Morpheme] = []
//
//        // 예시 데이터 추가
//        for i in 0 ..< 4 {
//            let newGlossary = Glossary(context: context)
//            newGlossary.id = UUID()
//            newGlossary.title = "title\(i)"
//            mockGlossarys.append(newGlossary)
//        }
    ////
//        for i in 0 ..< 10 {
//            let newTerm = Term(context: context)
//            newTerm.id = UUID()
//            newTerm.spelling = "spelling\(i)"
//            newTerm.meaning = "meaning\(i)"
//            newTerm.abbreviation = "abbreviation\(i)"
//            newTerm.explanation = "explanation\(i)"
//            newTerm.isBookmarked = false
//            mockTerms.append(newTerm)
//        }
    ////
//        for i in 0 ..< 4 {
//            let newMorpheme = Morpheme(context: context)
//            newMorpheme.id = UUID()
//            newMorpheme.spelling = "spelling\(i)"
//            newMorpheme.meaning = "meaning\(i)"
//            mockMorphemes.append(newMorpheme)
//        }
//
//        mockGlossarys[0].terms = [mockTerms[0], mockTerms[1], mockTerms[2]]
//        mockGlossarys[1].terms = [mockTerms[3], mockTerms[4], mockTerms[5]]
//        mockGlossarys[2].terms = [mockTerms[6], mockTerms[7], mockTerms[8]]
//        mockGlossarys[3].terms = [mockTerms[9], mockTerms[1], mockTerms[2]]
//
//        mockTerms[0].morphemes = [mockMorphemes[0], mockMorphemes[1]]
//        mockTerms[3].morphemes = [mockMorphemes[2]]
//        mockTerms[6].morphemes = [mockMorphemes[0], mockMorphemes[1]]
//        mockTerms[9].morphemes = [mockMorphemes[2]]
//
//        do {
//            try context.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error in preview \(nsError), \(nsError.userInfo)")
//        }
//
//        return controller
//    }()

    let container: NSPersistentCloudKitContainer

    // MARK: - CoreData Init

    // inMemory가 true일 경우 디스크에 저장되지 않음 (테스트, 프리뷰 용)
    init(inMemory: Bool = false) {
        print("Initializing PersistenceController with inMemory: \(inMemory)")

        container = NSPersistentCloudKitContainer(name: "MedicalModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }

//        container.persistentStoreDescriptions.first?.shouldMigrateStoreAutomatically = true
//        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = true

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - CoreData CRUD

extension PersistenceController {
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
