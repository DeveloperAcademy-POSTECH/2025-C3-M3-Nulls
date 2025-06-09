//
//  StudyTestDetailView.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct ReviewTestDetailView: View {
    @Binding var term: Term
    let testType: TestType
    let buttonText: String
    
    @Binding var termSize: Int
    @Binding var index: Int
    
    @Binding var isStudyInProgress: Bool
    @Binding var showSoundAlert: Bool
  
    var correctAnswer: String {
        switch testType {
        case .spelling:
            term.spelling ?? ""
        case .meaning:
            term.meaning ?? ""
        case .abbreviation:
            term.abbreviation ?? ""
        case .pronunciation:
            term.spelling ?? ""
        }
    }

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
                PronounciationTestView(term: term, showSoundAlert: $showSoundAlert)
            }
            
            VStack {
                AnswerView(
                    correctAnswer: correctAnswer,
                    index: $index,
                    termSize: $termSize,
                    isStudyInProgress: $isStudyInProgress,
                    showSoundAlert: $showSoundAlert,
                    term: $term, buttonText: buttonText
                )
                .padding(.bottom, 20)
                
                if showSoundAlert {
                    SoundAlert()
                }
            }
            
            Spacer()
        }
    }
}
