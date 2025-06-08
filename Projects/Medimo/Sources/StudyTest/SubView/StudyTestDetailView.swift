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
                    buttonText: buttonText
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

struct StudyTestDetailViewPreview: View {
    @State private var index = 1
    @State private var termSize = 3
    @State private var isStudyInProgress = true
    @State private var showSoundAlert = false

    var body: some View {
        let context = PersistenceController.preview.container.viewContext

        let term: Term = {
            let t = Term(context: context)
            t.spelling = "Blood Pressure"
            t.meaning = "혈압"
            t.abbreviation = "BP"
            t.id = UUID()
            return t
        }()

        let availableTestTypes = TestType.allCases.filter { type in
            switch type {
            case .abbreviation:
                return term.abbreviation != nil
            default:
                return true
            }
        }

        let randomTestType = availableTestTypes.randomElement()!

        return StudyTestDetailView(
            term: term,
            testType: randomTestType,
            buttonText: "다음 문제로",
            termSize: $termSize,
            index: $index,
            isStudyInProgress: $isStudyInProgress,
            showSoundAlert: $showSoundAlert
        )
        .environment(\.managedObjectContext, context)
    }
}

#Preview {
    StudyTestDetailViewPreview()
}