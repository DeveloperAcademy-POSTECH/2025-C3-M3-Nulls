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
        print("glossaryId: \(String(describing: glossaryId))")
        for progress in progressList ?? [] {
            print("progress: \(String(describing: progress.glossary?.id))")
        }
        return progressList?.first(where: { $0.glossary?.id == glossaryId })
    }
}

struct StudyMainCardView: View {
    @Environment(\.managedObjectContext) var moc
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
                StudyRingView(
                    progress: Int(studyManager.user.progressForGlossary(
                        studyManager.studyingGlossaryId!
                    )?.studiedCount ?? 0),
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
