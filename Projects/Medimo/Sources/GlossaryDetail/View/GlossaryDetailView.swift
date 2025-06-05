//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData
import SwiftUI

struct GlossaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var navigationManager: NavigationManager

    @State var viewModel: GlossaryDetailViewModel

    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: GlossaryDetailViewModel(glossary: glossary))
    }

    var body: some View {
        List {
            ForEach(viewModel.getTerms()) { term in
                Button {
                    navigationManager.push(to: .StudyCard(glossary: viewModel.glossary))
                } label: {
                    HStack {
                        Text(term.spelling ?? "")
                        Text(term.meaning ?? "")
                    }
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext

    GlossaryDetailView(
        glossary: try! context.fetch(Glossary.fetchRequest())[0]
    )
    .environmentObject(NavigationManager())
    .environment(\.managedObjectContext, context)
}
