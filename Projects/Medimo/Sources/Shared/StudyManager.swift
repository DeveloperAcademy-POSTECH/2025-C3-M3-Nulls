//
//  StudyManager.swift
//  Projects
//
//  Created by 양시준 on 6/2/25.
//

import Foundation
import CoreData

@Observable
public class StudyManager {
    var shared = StudyManager()
    
    private var context: NSManagedObjectContext?
    
    init() { }
    
    var studyTermSize: Int = 10
    
    func setContext(_ context: NSManagedObjectContext) {
        self.context = context
        
        let request: NSFetchRequest<Glossary> = Glossary.fetchRequest()
        request.fetchLimit = 1
        studyingGlossaryId = try? context.fetch(request).first?.id
    }
    
    var studyingGlossaryId: UUID? {
        didSet {
            _cachedStudyingGlossary = nil
            _cachedTermLearningStatusList = nil
        }
    }
    
    private var _cachedStudyingGlossary: Glossary?
    var studyingGlossary: Glossary? {
        if let cached = _cachedStudyingGlossary {
            return cached
        }
        
        guard let id = studyingGlossaryId else { return nil }

        let request: NSFetchRequest<Glossary> = Glossary.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        
        let result = try? context?.fetch(request).first
        _cachedStudyingGlossary = result
        return result
    }
    
    private var _cachedTermLearningStatusList: [TermLearningStatus]?
    var termLearnStatusList: [TermLearningStatus]? {
        if let cached = _cachedTermLearningStatusList {
            return cached
        }
        
        guard let studyingGlossaryId else { return nil }
        
        let request: NSFetchRequest<TermLearningStatus> = TermLearningStatus.fetchRequest()
        request.predicate = NSPredicate(format: "glossaryId == %@", studyingGlossaryId as CVarArg)
        
        let result = try? context?.fetch(request)
        _cachedTermLearningStatusList = result
        return result
    }
    
    func updateLearningStatus(of status: TermLearningStatus, to newStatus: LearningStatus) {
        status.status = newStatus.rawValue
        status.lastReviewedAt = Date()
        // TODO: 현재 1일 뒤 복습으로 적용되어 있으나 추후 업데이트 예정
        status.nextReviewAt = Date().addingTimeInterval(60 * 60 * 24 * 1)
        
        do {
            try context!.save()
        } catch {
            #if DEBUG
            print("Error updating learning status: \(error)")
            #endif
        }
    }
    
    func getNextStudyTerms() -> [Term] {
        guard studyingGlossaryId != nil else {
            return []
        }
        
        guard termLearnStatusList != nil else {
            return []
        }
        
        var termIdList: [UUID] = []
        let inProgressTermIdList: [UUID] = termLearnStatusList!.filter { $0.status == LearningStatus.inProgress.rawValue }.map { $0.termId! }
        termIdList.append(contentsOf: inProgressTermIdList.prefix(studyTermSize))
        if termIdList.count < studyTermSize {
            let notStartedTermIdList = termLearnStatusList!.filter { $0.status == LearningStatus.notStarted.rawValue }.map { $0.termId! }
            termIdList.append(contentsOf: notStartedTermIdList.prefix(studyTermSize - termIdList.count))
        }
        
        var result: [Term] = []
        while result.count < studyTermSize {
            if termIdList.isEmpty {
                break
            }
            
            let randomIndex = Int.random(in: 0..<termIdList.count)
            let termId = termIdList.remove(at: randomIndex)
            
            guard let term = studyingGlossary?.termsArray.first(where: { $0.id == termId }) else { continue }
            result.append(term)
        }
        
        return result
    }
}
