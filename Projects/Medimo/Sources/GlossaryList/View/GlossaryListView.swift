//
//  GlossaryListVie.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import SwiftUI
import CoreData

struct GlossaryListView: View {
    @Environment(\.managedObjectContext) var context
    @State private var viewModel: GlossaryListViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: GlossaryListViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.glossaries) { glossary in
                    NavigationLink(destination: GlossaryDetailView(glossary: glossary)) {
                        Text(glossary.title ?? "")
                    }
                }
            }
            .navigationTitle(Text("Glossary List"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    GlossaryListView(context: context)
        .environment(\.managedObjectContext, context)
}
