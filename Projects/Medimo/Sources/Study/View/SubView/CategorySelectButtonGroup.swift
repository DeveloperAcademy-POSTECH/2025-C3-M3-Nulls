//
//  CategorySelectButtonGroup.swift
//  Projects
//
//  Created by 양시준 on 6/8/25.
//

import SwiftUI

struct CategorySelectButtonGroup: View {
    @Binding var selectedCategory: MedicineCategory
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                ForEach(MedicineCategory.allCases, id: \.self) { category in
                    CategorySelectButton(category: category, selectedCategory: $selectedCategory)
                    if category != MedicineCategory.allCases.last! {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 1)
                .frame(height: 1)
                .foregroundStyle(AppColor.grey2)
        }
        .animation(.default, value: selectedCategory)
    }
}

#Preview {
    @Previewable @State var selectedCategory: MedicineCategory = .all
    CategorySelectButtonGroup(selectedCategory: $selectedCategory)
}
