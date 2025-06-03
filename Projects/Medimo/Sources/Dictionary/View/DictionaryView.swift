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
                Color(red: 0.9, green: 0.94, blue: 1.0)
                    .ignoresSafeArea(edges: .top)
                VStack {
                    Text("의학용어 사전")
                        .font(.system(size: 32, weight: .black, design: .default))
                        .padding(.top, 16)
                        .padding(.leading, 21)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .overlay(
                                TextField("단어를 입력하세요", text: $searchText)
                                    .padding(13)
                            )
                            .foregroundStyle(Color.white)
                            .frame(height: 60)
                        
//                        TextField("단어를 입력하세요", text: $searchText)
//                            .frame(height: 60)
//                            .padding(.leading, 13)
//                            .background(Color.white)
//                            .cornerRadius(20)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .frame(width: 348, height: 60, alignment: .trailing)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    
                    
                    List {
                        ForEach(viewModel.term.filter { searchText.isEmpty || ($0.spelling?.localizedCaseInsensitiveContains(searchText) ?? false) }) { term in
                            Button(action: {
                                selectedTerm = term
                            }) {
                                HStack {
                                    Text(term.spelling ?? "")
                                    Text(term.meaning ?? "")
                                }
                            }
                        }
                    }
                }
//                .navigationTitle(Text("의학용어 사전"))
//                .navigationBarTitleDisplayMode(.large)
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
