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
    
    @State private var showExitConfirm = false
    
    private var viewModel: StudyTestViewModel
    @State private var index: Int = 0
    
    @Binding var isStudyInProgress: Bool
    
    @State private var terms: [Term]
    @State private var studyTermSize: Int
    
    @State private var currentTestType: TestType = .spelling
    @State private var buttonText = "다음 문제로"
    
    @State private var showSoundAlert = false
    
    @Binding var learningType: LearningType
    
    @Binding var isAnswered: Bool
    
    init(
        terms: [Term],
        isStudyInProgress: Binding<Bool>,
        learningType: Binding<LearningType>,
        viewModel: StudyTestViewModel = StudyTestViewModel(),
        isAnswered: Binding<Bool>
    ) {
        self._terms = State(initialValue: terms)
        self._isStudyInProgress = isStudyInProgress
        self.viewModel = viewModel
        self._studyTermSize = State(initialValue: terms.count)
        self._learningType = learningType
        self._isAnswered = isAnswered
    }
    
    var body: some View {
        VStack {
            ProgressBar(index: index + 1, total: terms.count)
                .padding(.bottom, 48)
                .padding(.horizontal, 8)
            if index < studyTermSize {
                StudyTestDetailView(
                    term: $terms[index],
                    testType: currentTestType,
                    buttonText: buttonText,
                    termSize: $studyTermSize,
                    index: $index,
                    showSoundAlert: $showSoundAlert,
                    learningType: $learningType, isAnswered: $isAnswered
                )
            }
        }
        .padding(24)
        .background(AppColor.bgColor)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showExitConfirm = true
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(AppColor.grey3)
                }
            }
        }
        .alert("학습 종료하기", isPresented: $showExitConfirm) {
            Button("종료하기", role: .destructive) {
                isStudyInProgress = false
                navigationManager.studyPath = []
            }
            Button("취소", role: .cancel) {
            }
        } message: {
            Text("지금 나가면 진행 중인 학습이 초기화돼요.\n정말 종료할까요?")
        }
        .onAppear {
            currentTestType = randomValidTestType(for: terms[index])
        }
        .onChange(of: index) { _, newValue in
            if newValue == studyTermSize - 1 {
                buttonText = "학습 결과 보러가기"
            } else {
                buttonText = "다음 문제로"
                currentTestType = randomValidTestType(for: terms[newValue])
            }
        }
    }
    
    private func randomValidTestType(for term: Term) -> TestType {
        let availableTypes = TestType.allCases.filter { type in
            switch type {
            case .abbreviation:
                guard let abbr = term.abbreviation?
                        .trimmingCharacters(in: .whitespacesAndNewlines),
                      !abbr.isEmpty,
                      abbr != "-" else {
                    return false
                }
                return true
            default:
                return true
            }
        }
        return availableTypes.randomElement() ?? .meaning
    }
}
