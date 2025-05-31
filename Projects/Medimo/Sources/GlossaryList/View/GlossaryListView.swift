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
    @State var viewModel: GlossaryListViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: GlossaryListViewModel(context: context))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.glossaries) { glossary in
                Text(glossary.title ?? "")
            }
        }
    }
}

#Preview {
    GlossaryListView(context: PersistenceController.preview.container.viewContext)
}
