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
    var termFilter: GlossaryTermFilter = .notLearned
    
    init(glossary: Glossary) {
        self.glossary = glossary
    }
    
    func getTerms() -> [Term] {
        return glossary.terms?.allObjects as! [Term]
    }
    
}
