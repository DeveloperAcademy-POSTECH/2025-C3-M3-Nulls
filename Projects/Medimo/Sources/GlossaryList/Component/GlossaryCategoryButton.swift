//
//  GlossaryCategoryButton.swift
//  Projects
//
//  Created by Ell Han on 6/4/25.
//

import SwiftUI

struct GlossaryCategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("S-Core_Dream", size: 15))
                .foregroundColor(isSelected ? Color("MM_Text") : .white)
                .frame(width: 84, height: 40, alignment: .center)
                .background(isSelected ? Color.white : Color("MM_Blue"))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: -1)
                        .stroke(isSelected ? Color("MM_Grey2") : Color.clear, lineWidth: 2)
                )
        }
        .buttonStyle(.plain)
    }

}
#Preview("카테고리 버튼 토글") {
    struct PreviewWrapper: View {
        @State private var isSelected = false

        var body: some View {
            GlossaryCategoryButton(title: "카테고리", isSelected: isSelected) {
                isSelected.toggle()
            }
        }
    }

    return PreviewWrapper()
}
