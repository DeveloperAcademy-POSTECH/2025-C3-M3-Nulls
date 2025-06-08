//
//  StudyViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import Foundation

@Observable
class StudyViewModel {
    var studyingGlossary: Glossary {
        return StudyManager.shared.studyingGlossary!
    }
    
    // TODO: 연속 학습일 처리
    var streak: Int = 0
}
