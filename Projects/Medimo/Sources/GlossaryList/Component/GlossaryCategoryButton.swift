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
                .padding(.horizontal, 30)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                            .fill(isSelected ? AppColor.white : AppColor.systemFill)
                        TopSidesRoundedStroke(radius: 19, strokeWidth: 2)
                            .stroke(isSelected ? AppColor.grey2 : Color.clear, lineWidth: 2)
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

struct TopSidesRoundedStroke: Shape {
    var radius: CGFloat
    var strokeWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let inset = strokeWidth / 2

        let left = rect.minX + inset
        let right = rect.maxX - inset
        let top = rect.minY + inset
        let bottom = rect.maxY - inset

        let r = radius

        // 왼쪽부터 시작 → 위쪽 둥근 아크 → 오른쪽 아래로
        path.move(to: CGPoint(x: left, y: bottom)) // 시작 (보이지 않음)
        path.move(to: CGPoint(x: left, y: top + r))

        // 왼쪽 위 둥근 아크
        path.addArc(
            center: CGPoint(x: left + r, y: top + r),
            radius: r,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )

        // 위쪽 선
        path.addLine(to: CGPoint(x: right - r, y: top))

        // 오른쪽 위 둥근 아크
        path.addArc(
            center: CGPoint(x: right - r, y: top + r),
            radius: r,
            startAngle: .degrees(270),
            endAngle: .degrees(360),
            clockwise: false
        )

        // 오른쪽 선 아래로
        path.addLine(to: CGPoint(x: right, y: bottom))

        // 왼쪽 아래로 다시 연결
        path.move(to: CGPoint(x: left, y: top + r))
        path.addLine(to: CGPoint(x: left, y: bottom))

        return path
    }
}

#Preview("카테고리 버튼 토글") {
    struct PreviewWrapper: View {
        @State private var isSelected = false

        var body: some View {
            GlossaryCategoryButton(title: "전체", isSelected: isSelected) {
                isSelected.toggle()
            }
            .background(Color.black)
        }
    }

    return PreviewWrapper()
}
