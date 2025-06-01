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
class TermDetailViewModel {
    var term: Term
    
    init(term: Term) {
        self.term = term
    }
    
    func getMorphemes() -> [Morpheme] {
        return term.morphemes?.allObjects as! [Morpheme]
    }
}
