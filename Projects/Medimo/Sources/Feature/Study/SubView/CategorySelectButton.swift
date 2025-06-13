//
//  CategorySelectButton.swift
//  Projects
//
//  Created by 양시준 on 6/8/25.
//

import SwiftUI

struct CategorySelectButton: View {
    let category: MedicineCategory
    @Binding var selectedCategory: MedicineCategory

    var body: some View {
        Button(action: {
            selectedCategory = category
        }) {
            VStack(spacing: 24) {
                Text(category.rawValue)
                    .font(.headline)
                    .foregroundStyle(selectedCategory == category ? AppColor.secondaryLabel : AppColor.tertiaryLabel)
                Rectangle()
                    .frame(height: 4)
                    .foregroundColor(selectedCategory == category ? AppColor.grey2 : Color.clear)
                    .clipShape(TopRoundedRectangle(radius: 8))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var selectedCategory: MedicineCategory = .all
    CategorySelectButton(category: .all, selectedCategory: $selectedCategory)
}
