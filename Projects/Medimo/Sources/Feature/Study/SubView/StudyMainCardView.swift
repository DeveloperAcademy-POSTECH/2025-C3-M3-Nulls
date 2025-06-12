//
//  StudyMainCardView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

extension User {
    func progressForGlossary(_ glossaryId: Int64?) -> GlossaryProgress? {
        let progressList = progresses as? Set<GlossaryProgress>
        return progressList?.first(where: { $0.glossary?.id == glossaryId })
    }
}

struct StudyMainCardView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var navigationManager: NavigationManager
    let studyManager = StudyManager.shared

    @Binding var isStudyInProgress: Bool
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

                StudyRingView(
                    progress: Int(studyManager.currentGlossaryProgress?.studiedCount ?? 0),
                    total: studyManager.studyingGlossary?.terms?.count ?? 0
                )
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
                            if studyManager.getTodayReviewTerms().count > 0 {
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
