//
//  DictionarySearchBoxView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI

struct DictionarySearchBoxView: View {
    @Binding var searchText: String

    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .overlay(
                HStack {
                    TextField(
                        "",
                        text: $searchText,
                        prompt: Text("단어를 입력하세요")
                            .font(.caption)
                            .foregroundStyle(AppColor.grey3)
                    )
                    .foregroundStyle(AppColor.label)
                    .padding(21)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(AppColor.white)
                        .padding(7)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppColor.secondary)
                        )
                        .padding(10)
                }
            )
            .foregroundStyle(Color.white)
            .frame(height: 50)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    DictionarySearchBoxView(searchText: $searchText)
}
