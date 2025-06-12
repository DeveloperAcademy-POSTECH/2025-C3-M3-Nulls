//
//
//  GlossaryListVie.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import CoreData
import SwiftUI

struct DictionaryView: View {
    @State private var viewModel: DictionaryViewModel = .init()

    var body: some View {
        VStack(spacing: 0) {
            DictionaryHeaderView(searchText: $viewModel.searchText)

            DictionaryTermListView(viewModel: viewModel)
                .padding(.bottom, 64)

//            Spacer()
        }
        .background(AppColor.white)
        .padding(.top, 52)
        .sheet(item: $viewModel.selectedTerm) { term in
            DictionaryDetailView(term: term)
                .presentationDetents([.height(640)])
                .presentationDragIndicator(.visible)
        }
    }
}

// #Preview {
//    let context = CoreDataManager.preview.container.viewContext
//    DictionaryView()
// }
