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
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(isSelected ? AppColor.label : AppColor.white)
                .padding(.horizontal, 28)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                            .fill(isSelected ? AppColor.grey2 : Color.clear)
                            .padding(.horizontal, -1)
                            .padding(.top, -2)
                        RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                            .fill(isSelected ? AppColor.white : AppColor.systemFill)
                    }
                )
        }
        .buttonStyle(.plain)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview("카테고리 버튼 토글") {
    struct PreviewWrapper: View {
        @State private var isSelected = false

        var body: some View {
            GlossaryCategoryButton(title: "전체", isSelected: isSelected) {
                isSelected.toggle()
            }
        }
    }

    return PreviewWrapper()
}
