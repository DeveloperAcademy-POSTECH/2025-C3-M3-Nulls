
//
//  MorphemeDetailView.swift
//  Medimo
//
//  Created by bear on 6/2/25.
//

import Foundation
import CoreData
import Observation

@Observable
class MorphemeDetailView {
    var morpheme: Morpheme
    
    init(morpheme: Morpheme) {
        self.morpheme = morpheme
    }
    
    func getTerms() -> [Term] {
        return morpheme.terms?.allObjects as! [Term]
    }
}
