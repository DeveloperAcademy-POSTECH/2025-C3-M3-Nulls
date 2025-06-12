//
//  DictionaryTermItemView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI

struct DictionaryTermItemView: View {
    var term: Term
    @Binding var selectedTerm: Term?

    var body: some View {
        Button(action: {
            selectedTerm = term
        }) {
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    Text(term.spelling ?? "")
                        .font(.subheadlineEng)
                        .foregroundStyle(AppColor.label)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 10) {
                        if let abbreviation = term.abbreviation {
                            if !abbreviation.isEmpty {
                                Text("[ \(abbreviation) ]")
                                    .font(.subheadlineEng)
                                    .foregroundStyle(AppColor.label)
                            }
                        }
                        Text(term.meaning ?? "")
                            .font(.caption)
                            .foregroundStyle(AppColor.secondaryLabel)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                Rectangle()
                    .frame(height: 1)
                    .cornerRadius(2)
                    .padding(.horizontal, 14)
                    .foregroundStyle(AppColor.grey2)
            }
        }
        .listStyle(.plain)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}
//
//#Preview {
//    let context = CoreDataManager.preview.container.viewContext
//    @Previewable var viewModel = DictionaryViewModel()
//    let term = viewModel.term[0]
//    DictionaryTermItemView(term: term, selectedTerm: viewModel.selectedTerm)
//}
