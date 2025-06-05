
//
//  GlossaryListVie.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import SwiftUI
import CoreData

struct DictionaryView: View {
    @Environment(\.managedObjectContext) var context
    @Bindable private var viewModel: DictionaryViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = Bindable(wrappedValue: DictionaryViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    DictionaryHeaderView(searchText: $viewModel.searchText)
                }
                .zIndex(1)
                DictionaryTermListView(viewModel: viewModel)
            }
            
            .sheet(item: $viewModel.selectedTerm) { term in
                DictionaryDetailView(term: term)
                    .presentationDetents([.height(640)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


#Preview {
    let context = PersistenceController.shared.container.viewContext
    NavigationStack {
        DictionaryView(context: context)
            .environment(\.managedObjectContext, context)
    }
}
