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
    
    var terms: [Term]
    var studyTermSize: Int {
        terms.count
    }
    
    
    var answer: String = ""
    @State var buttonText = "다음 문제로"
    
    init(terms: [Term], index: Binding<Int>, viewModel: StudyTestViewModel = StudyTestViewModel()) {
        self.terms = terms
        self.viewModel = viewModel
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
                    buttonText: buttonText,
                    index: $index
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
    let context = PersistenceController.preview.container.viewContext

    var studyManager = StudyManager.shared
    studyManager.setContext(context)
    
    let terms = studyManager.getNextStudyTerms()

    return StudyTestView(
        terms: terms,
        index: .constant(1)
    )
    .environment(\.managedObjectContext, context)
}
