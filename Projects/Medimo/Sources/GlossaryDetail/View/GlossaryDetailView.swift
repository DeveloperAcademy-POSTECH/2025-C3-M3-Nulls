//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI
import CoreData

struct GlossaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    
    @State var viewModel: GlossaryDetailViewModel
    
    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: GlossaryDetailViewModel(glossary: glossary))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.getTerms()) { term in
                    NavigationLink(destination: TermDetailView(term: term)) {
                        HStack {
                            Text(term.spelling ?? "")
                            Text(term.meaning ?? "")
                        }
                    }
                }
            }
            .navigationTitle(viewModel.glossary.title ?? "")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    GlossaryDetailView(
        glossary: try! PersistenceController.preview.container.viewContext.fetch(Glossary.fetchRequest())[0]
    )
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
