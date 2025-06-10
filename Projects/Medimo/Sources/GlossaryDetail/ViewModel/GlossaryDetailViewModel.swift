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
    
    var termFilter: GlossaryTermFilter = .notLearned
    
    init(glossary: Glossary, currentCount: Int, totalCount: Int) {
        self.glossary = glossary
        self.currentCount = currentCount
        self.totalCount = totalCount
    }
    
    func getTerms() -> [Term] {
        return glossary.terms?.allObjects as! [Term]
    }
    
}
