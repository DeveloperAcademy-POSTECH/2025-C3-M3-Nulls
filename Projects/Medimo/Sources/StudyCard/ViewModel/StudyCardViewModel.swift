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
    
    var studyTermSize: Int {
        StudyManager.shared.studyTermSize
    }
    
    init() { }

    func getStudyTerms() -> [Term] {
        return studyManager.getNextStudyTerms()
    }
}
