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
    @Binding var isStudyInProgress: Bool

    var terms: [Term]
    @State private var studyTermSize: Int

    @State private var currentTestType: TestType = .spelling
    @State private var buttonText = "다음 문제로"

    init(
        terms: [Term],
        isStudyInProgress: Binding<Bool>,
        viewModel: StudyTestViewModel = StudyTestViewModel()
    ) {
        self.terms = terms
        self._isStudyInProgress = isStudyInProgress
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
                    buttonText: buttonText,
                    termSize: $studyTermSize,
                    index: $index,
                    isStudyInProgress: $isStudyInProgress
                )
            }
        }
        .padding(24)
        .background(AppColor.bgColor)
        .onAppear {
            currentTestType = randomValidTestType(for: terms[index - 1])
        }
        .onChange(of: index) { _, newValue in
            if newValue == studyTermSize {
                buttonText = "학습 결과 보러가기"
            } else {
                buttonText = "다음 문제로"
            }
            currentTestType = randomValidTestType(for: terms[newValue - 1])
        }
    }

    private func randomValidTestType(for term: Term) -> TestType {
        let availableTypes = TestType.allCases.filter { type in
            switch type {
            case .abbreviation:
                return term.abbreviation != nil
            default:
                return true
            }
        }
        return availableTypes.randomElement() ?? .meaning
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
