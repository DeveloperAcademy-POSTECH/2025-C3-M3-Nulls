//
//  StudyTestDetailView.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct StudyTestDetailView: View {
    let term: Term
    let testType: TestType
    let correctAnswer: String
    let buttonText: String
    
    @Binding var index: Int

    var body: some View {
        VStack {
            switch testType {
            case .spelling:
                SpellingTestView(term: term)
            case .meaning:
                MeaningTestView(term: term)
            case .abbreviation:
                AbbreviationTestView(term: term)
            case .pronunciation:
                PronounciationTestView(term: term)
            }

            AnswerView(
                correctAnswer: correctAnswer,
                index: $index,
                buttonText: buttonText
            )
        }
    }
}
