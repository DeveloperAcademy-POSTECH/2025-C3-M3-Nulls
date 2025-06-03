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
                Color(.MM_BG)
                    .ignoresSafeArea(edges: .top)
                VStack {
                    Text("의학용어 사전")
                        .font(.MM_H1)
                        .foregroundStyle(Color("MM_Text"))
                        .padding(.top, 16)
                        .padding(.leading, 26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .overlay(
                                TextField("단어를 입력하세요", text: $searchText)
                                    .foregroundStyle(Color("MM_Grey3"))
                                    .padding(21)
                            )
                            .foregroundStyle(Color.white)
                            .frame(height: 60)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("MM_Blue"))
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
                                
                                VStack{
                                    HStack {
                                        Text(term.spelling ?? "")
                                            .font(.MM_EAt)
                                            .foregroundColor(Color("MM_Text"))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 41)
                                        
                                        Image(systemName: "bookmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                            .foregroundStyle(Color("MM_Navy"))
                                            .padding(.trailing, 38)
                                    }.padding(.top, 10)
                                    
                                    HStack(spacing: 8) {
                                        Text("[ \(term.abbreviation ?? "") ]")
                                            .font(.MM_EAt)
                                            .foregroundColor(Color("MM_Text"))

                                        Text(term.meaning ?? "")
                                            .font(.MM_AT)
                                            .foregroundColor(Color("MM_Grey4"))

                                        Spacer()
                                    }
                                    .padding(.leading, 41)
                                    .padding(.bottom, 10)
                                    
                                }
                                .frame(width: 361, height: 73)
                                .background(Color.white)
                                Rectangle()
                                    .frame(width: 331, height: 1)
                                    .foregroundColor(Color.gray)
                                
                            }
                            .listStyle(.plain)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.white)
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
