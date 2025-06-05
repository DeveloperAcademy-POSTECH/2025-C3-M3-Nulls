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

    var viewModel: StudyViewModel

    init(glossary: Glossary) {
        viewModel = .init(studyingGlossary: glossary)
    }

    var body: some View {
        VStack {
            Button {
                navigationManager.push(to: .StudyCard(glossary: viewModel.studyingGlossary))
            } label: {
                Text("Study")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                    )
            } // Button

            Button {
                Task {
                    let result = await cloudKitManager.fetchAllTerms()
                    switch result {
                    case let .success(loadedTerms):
//                        print("Fetched terms: \(loadedTerms)")
                        print("Number of terms fetched: \(loadedTerms.count)")
                        for term in loadedTerms {
                            print("✏️ \(term.spelling)")
                        }

                    case let .failure(error):
                        print("Error fetching terms: \(error)")
                    }
                }
            } label: {
                Text("Fetch Terms")
            }
        } // VStack
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]

    StudyView(glossary: glossary)
        .environmentObject(NavigationManager())
}
