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
    @State var index: Int = 1
    @State private var currentTestType: TestType = TestType.allCases.randomElement()!
    
    @Binding var isStudyInProgress: Bool
    
    var terms: [Term]
    @State private var studyTermSize: Int
    
    
    var answer: String = ""
    @State var buttonText = "다음 문제로"
    
    init(
        terms: [Term],
        isStudyInProgress: Binding<Bool>, // ✅ 바인딩 추가
        viewModel: StudyTestViewModel = StudyTestViewModel()
    ) {
        self.terms = terms
        self._isStudyInProgress = isStudyInProgress // ✅ 언더바(_) 붙여야 함!
        self.viewModel = viewModel
        _studyTermSize = State(initialValue: terms.count)
    }
    
    var body: some View {
        VStack {
            ProgressBar(index: index, total: terms.count)
                .padding(.bottom, 48)
                .padding(.horizontal, 8)

            if terms.indices.contains(index - 1) {
                StudyTestDetailView(
                    term: terms[index - 1],
                    testType: currentTestType,
                    // TODO: 테스트마다 정답 다르게 하기
                    correctAnswer: terms[index - 1].spelling ?? "",
                    buttonText: buttonText, termSize: $studyTermSize,
                    index: $index,
                    isStudyInProgress: $isStudyInProgress
                )
            }
        }
        .padding(24)
        .background(AppColor.bgColor)
        .onChange(of: index) { _, newValue in
            if newValue == studyTermSize {
                buttonText = "학습 결과 보러가기"
            } else {
                buttonText = "다음 문제로"
            }
            currentTestType = TestType.allCases.randomElement()!
        }
    }
}

#Preview {
    @Previewable @State var dummyInProgress = true
    let context = PersistenceController.preview.container.viewContext
    let studyManager = StudyManager.shared
    studyManager.setContext(context)
    let terms = studyManager.getNextStudyTerms()
    
    return StudyTestView(
        terms: terms,
        isStudyInProgress: $dummyInProgress
    )
    .environment(\.managedObjectContext, context)
}
