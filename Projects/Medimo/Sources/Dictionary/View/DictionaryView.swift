
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
    @State private var viewModel: DictionaryViewModel
    @State private var selectedTerm: Term? = nil
    @State private var searchText: String = ""
    
    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: DictionaryViewModel(context: context))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(AppColor.secondarySystemFill)
                    .ignoresSafeArea(edges: .top)
                
                VStack {
                    DictionaryViewComponents.searchHeader(searchText: $searchText)

                    DictionaryViewComponents.termList(viewModel: viewModel, selectedTerm: $selectedTerm, searchText: searchText)
                        .mask(Rectangle())
                }
                
                .sheet(item: $selectedTerm) { term in
                    DictionaryDetailView(term: term)
                        .presentationDetents([.height(641)])
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }
}


#Preview {
    let context = PersistenceController.preview.container.viewContext
    DictionaryView(context: context)
        .environment(\.managedObjectContext, context)
}
