//
//  GlossaryCategoryBar.swift
//  Projects
//
//  Created by Ell Han on 6/4/25.
//

//
//  GlossaryCategoryBar.swift
//  Projects
//
//  Created by Ell on 2025/06/04.
//

import SwiftUI

struct GlossaryCategoryBar: View {
    @Binding var selectedCategory: String

    var body: some View {
        HStack(alignment: .center) {
            GlossaryCategoryButton(
                title: "전체",
                isSelected: selectedCategory == "전체",
                action: { selectedCategory = "전체" }
            )
            Spacer()
            GlossaryCategoryButton(
                title: "외과",
                isSelected: selectedCategory == "외과",
                action: { selectedCategory = "외과" }
            )
            Spacer()
            GlossaryCategoryButton(
                title: "내과",
                isSelected: selectedCategory == "내과",
                action: { selectedCategory = "내과" }
            )
            Spacer()
            GlossaryCategoryButton(
                title: "기타",
                isSelected: selectedCategory == "기타",
                action: { selectedCategory = "기타" }
            )
        }
        .frame(width: 361)
        .padding(0)
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper("전체") { selected in
        GlossaryCategoryBar(selectedCategory: selected)
    }
}
