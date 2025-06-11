//
//  GlossaryCategoryBar.swift
//  Projects
//
//  Created by Ell on 2025/06/04.
//

import SwiftUI

struct GlossaryCategoryBar: View {
    @Binding var selectedCategory: MedicineCategory

    var body: some View {
        HStack {
            Spacer()
            ForEach(MedicineCategory.allCases, id: \.self) { category in
                GlossaryCategoryButton(
                    title: category.rawValue,
                    isSelected: selectedCategory == category,
                    action: { selectedCategory = category }
                )
            }
            Spacer()
        }
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
    @Previewable @State var selectedCategory: MedicineCategory = .all
    
    GlossaryCategoryBar(selectedCategory: $selectedCategory)
}
