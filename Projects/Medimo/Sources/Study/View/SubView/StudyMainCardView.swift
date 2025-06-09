//
//  StudyMainCardView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyMainCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let studyManager = StudyManager.shared
    
    @Binding var isStudyInProgress: Bool
    @Binding var isStudyDone: Bool
    @State private var showAlert = false

    var body: some View {
        ZStack {
            StudyMainCardBackgroundView()
            VStack {
                HStack {
                    StudyingGloassaryChooseButtonView()
                    Spacer()
                    StudyTermSizeChooseButtonView()
                }

                // TODO: 학습 진행도 반영
                StudyRingView(progress: 10, total: 100)
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                VStack(spacing: 16) {
                    StudyStartButtonView {
                        isStudyInProgress = true
                        navigationManager.studyPath.append(.StudyCard)
                    }
                    .padding(.horizontal, 20)

                    ReviewStartButtonView(
                        action: {
                            if isStudyDone {
                                isStudyInProgress = true
                                navigationManager.studyPath.append(.ReviewTest)
                            } else {
                                showAlert = true
                            }
                        }
                    )
                    .padding(.horizontal, 20)
                    .alert("리뷰를 시작할 수 없어요", isPresented: $showAlert) {
                        Button("확인", role: .cancel) {}
                    } message: {
                        Text("학습을 먼저 완료해주세요!")
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 42)
            .padding(.bottom, 36)
        }
    }
}
