//
//  DictionaryComponentsView.swift
//  Medimo
//
//  Created by bear on 6/5/25.
//

import SwiftUI

struct DictionaryViewComponents {
    static func searchHeader(searchText: Binding<String>) -> some View {
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
                            text: searchText,
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
        }
    }
    static func termList(viewModel: DictionaryViewModel, selectedTerm: Binding<Term?>, searchText: String) -> some View {
        List {
            ForEach(viewModel.term.filter { searchText.isEmpty || ($0.spelling?.localizedCaseInsensitiveContains(searchText) ?? false) }) { term in
                Button(action: {
                    selectedTerm.wrappedValue = term
                }) {
                    VStack(spacing: 0) {
                        Text(term.spelling ?? "")
                            .font(.subheadlineEng)
                            .foregroundColor(AppColor.label)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 10) {
                            if let abbreviation = term.abbreviation {
                                Text("[ \(abbreviation) ]")
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
}


#Preview("Search + List") {
    struct PreviewWrapper: View {
        @State private var searchText = ""
        @State private var selectedTerm: Term? = nil
        let viewModel: DictionaryViewModel = {
            let context = PersistenceController.preview.container.viewContext
            let term1 = Term(context: context)
            term1.spelling = "Cardiology"
            term1.abbreviation = "Cardio"
            term1.meaning = "Study of the heart"

            let term2 = Term(context: context)
            term2.spelling = "Neurology"
            term2.abbreviation = "Neuro"
            term2.meaning = "Study of the brain and nervous system"

            let vm = DictionaryViewModel(context: context)
            vm.term = [term1, term2]
            return vm
        }()

        var body: some View {
            VStack {
                DictionaryViewComponents.searchHeader(searchText: $searchText)
                DictionaryViewComponents.termList(viewModel: viewModel, selectedTerm: $selectedTerm, searchText: searchText)
            }
            .padding()
        }
    }

    return PreviewWrapper()
}
