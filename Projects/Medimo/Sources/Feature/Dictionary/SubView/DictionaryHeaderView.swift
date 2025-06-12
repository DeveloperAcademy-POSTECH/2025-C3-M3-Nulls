//
//  DictionaryHeaderView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI

struct DictionaryHeaderView: View {
    @Binding var searchText: String

    var body: some View {
        VStack {
            Text("의학용어 사전")
                .font(.largeTitle)
                .foregroundStyle(AppColor.label)
                .padding(.top, 33)
                .padding(.leading, 26)
                .frame(maxWidth: .infinity, alignment: .leading)
            DictionarySearchBoxView(searchText: $searchText)
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .background(
            Color(AppColor.secondarySystemFill)
        )
    }
}

#Preview {
    @Previewable @State var searchText = ""
    DictionaryHeaderView(searchText: $searchText)
}
