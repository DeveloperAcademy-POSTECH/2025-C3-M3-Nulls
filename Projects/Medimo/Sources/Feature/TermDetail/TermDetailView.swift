//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData
import SwiftUI

struct TermDetailView: View {
    @Environment(\.managedObjectContext) var context

    @State var viewModel: TermDetailViewModel

    init(term: Term) {
        _viewModel = State(wrappedValue: TermDetailViewModel(term: term))
    }

    var body: some View {
        NavigationStack {
            List {
                Text(viewModel.term.meaning ?? "")
                Text(viewModel.term.abbreviation ?? "")
                Text(viewModel.term.explanation ?? "")
                ForEach(viewModel.getMorphemes()) { morpheme in
                    HStack {
                        Text(morpheme.spelling ?? "")
                        Text(morpheme.meaning ?? "")
                    }
                }
            }
            .navigationTitle(viewModel.term.spelling ?? "")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TermDetailView(
        term: try! CoreDataManager.preview.container.viewContext.fetch(Term.fetchRequest())[0]
    )
    .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
