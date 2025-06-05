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
                        .foregroundStyle(AppColor.label)
                        .padding(21)
                    )
                    .foregroundStyle(Color.white)
                    .frame(height: 50)
                
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(AppColor.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.trailing, 10)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
                
//            Color.white
//                .frame(height:20)
//                .padding(.bottom, -10)
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
                            .foregroundStyle(AppColor.label)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                        
                        HStack(spacing: 10) {
                            if let abbreviation = term.abbreviation {
                                Text("[ \(abbreviation) ]")
                                    .font(.subheadlineEng)
                                    .foregroundStyle(AppColor.label)
                            }
                            Text(term.meaning ?? "")
                                .font(.caption)
                                .foregroundStyle(AppColor.secondaryLabel)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.horizontal, 16)
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.horizontal, 12)
                        .cornerRadius(2)
                        .foregroundStyle(AppColor.grey2)
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


