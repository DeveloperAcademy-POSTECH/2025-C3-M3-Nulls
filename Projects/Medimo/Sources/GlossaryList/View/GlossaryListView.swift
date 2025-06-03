//
//  GlossaryListVie.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import CoreData
import SwiftUI

struct GlossaryListView: View {
    @Environment(\.managedObjectContext) var context
    @State private var viewModel: GlossaryListViewModel
    @EnvironmentObject var navigationManager: NavigationManager

    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: GlossaryListViewModel(context: context))
    }

    var body: some View {
        List {
            ForEach(viewModel.glossaries) { glossary in
                Button {
                    navigationManager.push(to: .GlossaryDetail(glossary: glossary))
                } label: {
                    Text(glossary.title ?? "")
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    GlossaryListView(context: context)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
