//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData
import SwiftUI

struct GlossaryDetailView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) var context

    @State var viewModel: GlossaryDetailViewModel

    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: GlossaryDetailViewModel(glossary: glossary))
    }

    var body: some View {
        List {
            ForEach(viewModel.getTerms()) { term in
                Button {
                    navigationManager.push(to: .StudyTermList(glossary: viewModel.glossary))
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
    GlossaryDetailView(
        glossary: try! PersistenceController.preview.container.viewContext.fetch(Glossary.fetchRequest())[0]
    )
    .environmentObject(NavigationManager())
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
