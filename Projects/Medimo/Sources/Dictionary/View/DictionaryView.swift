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
                    Text("의학용어 사전")
                        .font(.largeTitle)
                        .foregroundStyle(AppColor.label)
                        .padding(.top, 33)
                        .padding(.leading, 26)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .overlay(
                                TextField(
                                    "",
                                    text: $searchText,
                                    prompt: Text("단어를 입력하세요")
                                        .font(.caption)
                                )
                                .foregroundColor(AppColor.label)
                                .padding(21)
                                
                            )
                            .foregroundStyle(Color.white)
                            .frame(height: 50)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(AppColor.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .frame(width: 361, height: 50, alignment: .trailing)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
        
                    List {
                        ForEach(viewModel.term.filter { searchText.isEmpty || ($0.spelling?.localizedCaseInsensitiveContains(searchText) ?? false) }) { term in
                            Button(action: {
                                selectedTerm = term
                            }) {
                                
                                VStack(spacing: 0){
                                    Text(term.spelling ?? "")
                                        .font(.subheadlineEng)
                                        .foregroundColor(AppColor.label)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 16)
                                        .padding(.bottom, 8)
                                        
                                    HStack(spacing: 10) {
                                        if term.abbreviation != nil {
                                            Text("[ \(term.abbreviation ?? "") ]")
                                                .font(.subheadlineEng)
                                                .foregroundColor(AppColor.label)
                                        }
                                        Text(term.meaning ?? "")
                                            .font(.caption)
                                            .foregroundColor(AppColor.secondaryLabel)
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 8)
                                }
                                .padding(.horizontal, 16)
                                
                                Rectangle()
                                    .frame(height: 1)
                                    .padding(.horizontal, 12)
                                    .cornerRadius(2)
                                    .foregroundColor(AppColor.grey2)
                                
                            }
                            .listStyle(.plain)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .padding(.top, -16)
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
