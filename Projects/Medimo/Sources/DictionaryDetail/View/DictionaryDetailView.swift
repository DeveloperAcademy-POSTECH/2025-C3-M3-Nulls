//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI
import CoreData

struct DictionaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    
    @State var viewModel: DictionaryDetailViewModel
    
    init(term: Term) {
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }
    
    var body: some View {
        NavigationStack {
                    VStack {
                        Text(viewModel.term.abbreviation ?? "[no abbreviation]")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title2)
                            .padding(.horizontal,32)
                            
                        
                        Spacer()
                        
                        Text(
                            (viewModel.term.glossarys as? Set<Glossary>)?
                                .compactMap { $0.title }
                                .joined(separator:  ", ") ?? ""
                        )
                        Text(viewModel.term.meaning ?? "")
                        HStack {
                            Text(
                                (viewModel.term.morphemes as? Set<Morpheme>)?
                                    .compactMap { $0.meaning }
                                    .joined(separator: ", ") ?? ""
                            )
                            Text(
                                (viewModel.term.morphemes as? Set<Morpheme>)?
                                    .compactMap { $0.spelling }
                                    .joined(separator: ", ") ?? ""
                            )
                        }
                        Text(viewModel.term.explanation ?? "")
                        
                        Spacer()
                        
                    }
                    .navigationTitle(viewModel.term.spelling ?? "")
                    .navigationBarTitleDisplayMode(.large)
                }
            }
        }
#Preview {
    DictionaryDetailView(
        term: try! PersistenceController.preview.container.viewContext.fetch(Term.fetchRequest())[1]
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


//abbreviation: String?
//explanation: String?
//id: UUID?
//meaning: String?
//spelling: String?
//termKey: String?
//glossarys: NSSet?
//morphemes: NSSet?
