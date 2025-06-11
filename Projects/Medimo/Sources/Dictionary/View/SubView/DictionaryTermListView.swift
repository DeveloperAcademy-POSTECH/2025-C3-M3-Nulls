//
//  DictionaryTermListView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import CoreData
import SwiftUI

struct DictionaryTermListView: View {
    @Bindable var viewModel: DictionaryViewModel

    init(viewModel: DictionaryViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredTerms) { term in
                    DictionaryTermItemView(term: term, selectedTerm: $viewModel.selectedTerm)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .scrollContentBackground(.hidden)
    }
}

// #Preview {
//    let context = CoreDataManager.preview.container.viewContext
//    DictionaryTermListView(viewModel: .init())
// }
