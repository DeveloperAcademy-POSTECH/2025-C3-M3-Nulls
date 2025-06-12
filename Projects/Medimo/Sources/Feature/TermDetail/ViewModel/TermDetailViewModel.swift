//
//  TermListViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData
import Foundation
import Observation

@Observable
class TermDetailViewModel {
    var term: Term

    init(term: Term) {
        self.term = term
    }

    func getMorphemes() -> [Morpheme] {
        return (term.morphemes)?
            .array as? [Morpheme] ?? []
    }
}
