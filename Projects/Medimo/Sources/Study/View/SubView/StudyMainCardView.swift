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

                    ReviewStartButtonView {
                        isStudyInProgress = true
                        navigationManager.studyPath.append(.ReviewTest)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 42)
            .padding(.bottom, 36)
        }
    }
}

#Preview {
    @Previewable @State var isStudyInProgress = true
    @Previewable @State var studyManager = StudyManager.shared
    let context = CoreDataManager.preview.container.viewContext

    studyManager.setContext(context)

    return ScrollView {
        StudyMainCardView(isStudyInProgress: $isStudyInProgress)
            .padding(16)
    }
    .environment(\.managedObjectContext, context)
}
