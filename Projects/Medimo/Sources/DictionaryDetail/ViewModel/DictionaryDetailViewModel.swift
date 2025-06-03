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
class DictionaryDetailViewModel {
    var term: Term
    var morphemes: String = ""
    
    init(term: Term) {
        self.term = term
    }
    func parseMorphemes(_ term: Term) -> String {
        let morphemes = (term.morphemes as? Set<Morpheme>)?
            .compactMap { "\($0.spelling ?? ""): \($0.meaning ?? "")" }
            .joined(separator: "\n")
        return morphemes ?? "없음"
    }
}
