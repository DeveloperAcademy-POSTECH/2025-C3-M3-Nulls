//
//  StudyViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import Foundation

@Observable
class StudyViewModel {
    var studyingGlossary: Glossary = StudyManager.shared.studyingGlossary!
    
    // TODO: 연속 학습일 처리
    var streak: Int = 0
    
    init(studyingGlossary: Glossary) {
        self.studyingGlossary = studyingGlossary
    }
    
    func changeStudyingGlossary(_ newGlossary: Glossary) {
        self.studyingGlossary = newGlossary
    }
}
