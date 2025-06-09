//
//  StudyTestDetailView.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct StudyTestDetailView: View {
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
                    term: $term,
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

struct StudyTestDetailViewPreviewWrapper: View {
    @State private var termSize = 3
    @State private var index = 1
    @State private var isStudyInProgress = true
    @State private var showSoundAlert = false
    @State private var term: Term

    init() {
        let context = PersistenceController.preview.container.viewContext
        let sampleTerm = Term(context: context)
        sampleTerm.spelling = "Blood Pressure"
        sampleTerm.meaning = "혈압"
        sampleTerm.abbreviation = "BP"
        sampleTerm.id = UUID()
        _term = State(initialValue: sampleTerm)
    }

    var body: some View {
<<<<<<< HEAD
        StudyTestDetailView(
            term: $term,
            testType: .meaning,
=======
        let context = CoreDataManager.preview.container.viewContext

        let term: Term = {
            let t = Term(context: context)
            t.spelling = "Blood Pressure"
            t.meaning = "혈압"
            t.abbreviation = "BP"
            t.id = 1
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
>>>>>>> b70ff45aa32b82f212d88b4a376492e85e8509ae
            buttonText: "다음 문제로",
            termSize: $termSize,
            index: $index,
            isStudyInProgress: $isStudyInProgress,
            showSoundAlert: $showSoundAlert
        )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

#Preview {
<<<<<<< HEAD
    StudyTestDetailViewPreviewWrapper()
=======
    StudyTestDetailViewPreview()
>>>>>>> b70ff45aa32b82f212d88b4a376492e85e8509ae
}
