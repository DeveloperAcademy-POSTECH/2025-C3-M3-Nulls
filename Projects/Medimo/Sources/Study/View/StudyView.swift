//
//  StudyView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let cloudKitManager = CloudKitManager.shared
    @Bindable var viewModel: StudyViewModel
    @Bindable var studyManager = StudyManager.shared

    @State private var isAtTop: Bool = true

    init(glossary: Glossary) {
        viewModel = .init(studyingGlossary: glossary)
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    StudyHeaderView(streak: viewModel.streak)
                    StudyMainCardView(
                        studyingGlossary: $viewModel.studyingGlossary,
                        studyTermSize: $studyManager.studyTermSize
                    )
                    .padding(.top, 42)
                    .padding(.horizontal, 16)
                    StudyCalendarCardView()
                        .padding(16)
                }
                .background(
                    StudyHeaderBackgroundView()
                )
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
            .background(AppColor.systemGroupedBackground)
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]

    StudyView(glossary: glossary)
        .environmentObject(NavigationManager())
}
