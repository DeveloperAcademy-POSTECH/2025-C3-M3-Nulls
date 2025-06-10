//
//  TermListViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import Foundation
import CoreData
import Observation

@Observable
class GlossaryDetailViewModel {
    var glossary: Glossary
    var currentCount: Int
    var totalCount: Int
    
    var selectedTerm: Term?
    
    var termStudyFilter: TermStudyFilter = .learned
    
    init(glossary: Glossary, currentCount: Int, totalCount: Int) {
        self.glossary = glossary
        self.currentCount = currentCount
        self.totalCount = totalCount
    }
    
    var terms: [Term] {
        return glossary.terms?.allObjects as! [Term]
    }
    
    var filteredTerms: [Term] {
        return terms.filter {
            guard let studyData = $0.termStudyData?.allObjects.first as? TermStudyData else {
                return false
            }
            switch termStudyFilter {
            case .learned:
                return studyData.status == LearningStatus.completed.rawValue
            case .notLearned:
                return studyData.status == LearningStatus.notStarted.rawValue || studyData.status == LearningStatus.inProgress.rawValue
            }
        }
    }
}
