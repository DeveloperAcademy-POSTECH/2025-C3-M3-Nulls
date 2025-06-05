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
    @State private var index: Int = 1
    
    var terms: [Term]
    var studyTermSize: Int {
        terms.count
    }
    var answer: String = ""
    
    init(terms: [Term], viewModel: StudyTestViewModel = StudyTestViewModel()) {
        self.terms = terms
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack() {
            ProgressBar(index: index, total: terms.count)
                .padding(.bottom, 48)
                .padding(.horizontal, 8)
            
            // TODO: 문제 넘어갈 때마다 문제 바뀌는 것 다른 걸로 구현
//            SpellingTestView(term: terms[0])
//            MeaningTestView(term: terms[0])
            AbbreviationTestView(term: terms[0])
//            PronounciationTestView(term: terms[0])
            
            AnswerTextBox(answer: answer)
            
            CorrectAnswer()
            // TODO: 문제 유형에 따라 다른 답 넘기기
//            WrongAnswer(correctAnswer: terms[0].spelling ?? "")
            Spacer()
            // TODO: 답 입력하면 나타나게 설정
            NextButton(buttonText: "다음 문제로")
//            NextButton(buttonText: "학습 결과 보러가기")
                .opacity(index == studyTermSize ? 1 : 0)
        }
        .padding(24)
        .background(AppColor.bgColor.ignoresSafeArea())
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
