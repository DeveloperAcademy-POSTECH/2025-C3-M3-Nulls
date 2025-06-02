//
//  StudyView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI

struct StudyView: View {
  @EnvironmentObject var navigationManager: NavigationManager
  var viewModel: StudyViewModel

  init(glossary: Glossary) {
    viewModel = .init(studyingGlossary: glossary)
  }

  var body: some View {
    Button {
      navigationManager.push(to: .StudyTermList(glossary: viewModel.studyingGlossary))
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
    }
  }
}

#Preview {
  let context = PersistenceController.preview.container.viewContext
  let glossary = try! context.fetch(Glossary.fetchRequest())[0]

  StudyView(glossary: glossary)
    .environmentObject(NavigationManager())
}
