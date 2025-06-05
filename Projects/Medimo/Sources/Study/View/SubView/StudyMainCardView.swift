//
//  StudyMainCardView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyMainCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Binding var studyingGlossary: Glossary
    @Binding var studyTermSize: Int
    
    var body: some View {
        ZStack {
            StudyMainCardBackgroundView()
            VStack {
                HStack {
                    StudyingGloassaryChooseButtonView()
                    Spacer()
                    StudyTermSizeChooseButtonView()
                }
                StudyRingView()
                    .padding(.top, 28)
                    .padding(.bottom, 32)
                VStack(spacing: 16) {
                    StudyStartButtonView(action: {
                        navigationManager.push(to: .StudyCard(glossary: studyingGlossary))
                    })
                        .padding(.horizontal, 20)
                    ReviewStartButtonView()
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
    let context = PersistenceController.preview.container.viewContext
    var glossary = try! context.fetch(Glossary.fetchRequest())[0]
    @Bindable var viewModel = StudyViewModel(studyingGlossary: glossary)
    @Bindable var studyManager = StudyManager.shared
    ScrollView {
        StudyMainCardView(
            studyingGlossary: $viewModel.studyingGlossary,
            studyTermSize: $studyManager.studyTermSize
        )
            .padding(16)
    }
}
