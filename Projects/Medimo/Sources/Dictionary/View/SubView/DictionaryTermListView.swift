//
//  DictionaryTermListView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI
import CoreData

struct DictionaryTermListView: View {
    @Bindable var viewModel: DictionaryViewModel
    
    init(viewModel: DictionaryViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.filteredTerms) { term in
                    DictionaryTermItemView(term: term, selectedTerm: $viewModel.selectedTerm)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    DictionaryTermListView(viewModel: .init(context: context))
}
