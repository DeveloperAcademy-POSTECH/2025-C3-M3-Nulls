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
                PronounciationTestView(term: term)
            }

            AnswerView(
                correctAnswer: correctAnswer,
                index: $index,
                termSize: $termSize,
                isStudyInProgress: $isStudyInProgress,
                buttonText: buttonText
            )
        }
    }
}

#Preview {
    @Previewable @State var index = 1
    @Previewable @State var termSize = 3
    @Previewable @State var isStudyInProgress = true

    // abbreviation이 있는 더미 Term 객체 생성
    let term = Term(context: PersistenceController.preview.container.viewContext)
    term.spelling = "Blood Pressure"
    term.meaning = "혈압"
    term.abbreviation = "BP"
    term.id = UUID()

    // 해당 term이 abbreviation이 있으므로, 가능한 testType 리스트 구성
    let availableTestTypes: [TestType] = TestType.allCases.filter { type in
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
        isStudyInProgress: $isStudyInProgress
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
