//
//  StudyTermListViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import Foundation
import CoreData
import Observation

@Observable
class StudyCardViewModel {
    private let studyManager = StudyManager.shared
    var studyTerm: [Term] = []
    
    var studyTermSize: Int {
        StudyManager.shared.studyTermSize
    }
    
    init() { }

    func getStudyTerms() -> [Term] {
        studyTerm = studyManager.getNextStudyTerms()
        return studyTerm
    }
    
    func cardPosition(for index: Int, currentIndex: Int?) -> CardBackgroundModifier.CardPosition {
        if index == currentIndex {
            return .center
        } else if index < (currentIndex ?? 0) {
            return .left
        } else {
            return .right
        }
    }
}
