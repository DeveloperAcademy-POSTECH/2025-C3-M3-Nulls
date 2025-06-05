//
//  StudyTestView.swift
//  Projects
//
//  Created by 이서현 on 6/3/25.
//

import SwiftUI

struct StudyTestView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) private var context
    
    private var viewModel: StudyTestViewModel
    @State private var index: Int = 4
    
    @State private var currentTestType: TestType = TestType.allCases.randomElement()!
    
    var terms: [Term]
    var studyTermSize: Int {
        terms.count
    }
    
    var answer: String = ""
    @State var buttonText = "다음 문제로"
    
    init(terms: [Term], viewModel: StudyTestViewModel = StudyTestViewModel()) {
        self.terms = terms
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack() {
            ProgressBar(index: index, total: terms.count)
                .padding(.bottom, 48)
                .padding(.horizontal, 8)
            
            switch currentTestType {
            case .spelling:
                SpellingTestView(term: terms[0])
            case .meaning:
                MeaningTestView(term: terms[0])
            case .abbreviation:
                AbbreviationTestView(term: terms[0])
            case .pronunciation:
                PronounciationTestView(term: terms[0])
            }
            AnswerView(correctAnswer: terms[0].spelling ?? "", answer: answer, buttonText: buttonText)
//                SpellingTestView(term: terms[0])
                //            MeaningTestView(term: terms[0])
                //            AbbreviationTestView(term: terms[0])
                //            PronounciationTestView(term: terms[0])
                
//                AnswerView(correctAnswer: terms[0].spelling ?? "", answer: answer, buttonText: buttonText)
        }
        .padding(24)
        .background(AppColor.bgColor.ignoresSafeArea())
        .onChange(of: index) { oldIndex, newIndex in
            if newIndex == studyTermSize {
                buttonText = "학습 결과 보러가기"
            } else {
                buttonText = "다음 문제로"
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext

    let fallbackTerm = Term(context: context)
    fallbackTerm.id = UUID()
    fallbackTerm.spelling = "Fallback"
    fallbackTerm.meaning = "임시 값"

    StudyManager.shared.setContext(context)
    let terms = StudyManager.shared.getNextStudyTerms()

    return StudyTestView(terms: terms.isEmpty ? [fallbackTerm] : terms)
        .environment(\.managedObjectContext, context)
}
