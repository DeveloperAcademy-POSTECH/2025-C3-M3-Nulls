//
//  GlossaryCardView.swift
//  Projects
//
//  Created by Ell Han on 6/4/25.
//


import SwiftUI

struct GlossaryCardView: View {
    let title: String
    let currentCount: Int
    let totalCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .font(.body)
                .kerning(0.1)
                .multilineTextAlignment(.leading)
                .foregroundStyle(AppColor.label)
            Capsule()
                .fill(AppColor.secondarySystemFill)
                .frame(height: 8)
                .overlay(
                    GeometryReader { geometry in
                        Capsule()
                            .fill(AppColor.systemFill)
                            .frame(width: geometry.size.width * CGFloat(currentCount)/CGFloat(totalCount), height: 8)
                    }
                    .clipShape(Capsule())
                )
            HStack(alignment: .bottom, spacing: 4) {
                Spacer()
                Text("\(String(format: "%d", currentCount))")
                    .font(.bodyEng)
                    .foregroundStyle(AppColor.label)

                Text("/\(totalCount)")
                    .font(.caption)
                    .foregroundColor(AppColor.secondarySystemFill)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColor.primary.opacity(0.35), radius: 2.5, x: 0, y: 2)
    }
}

#Preview {
    GlossaryCardView(title: "북마크", currentCount: 30, totalCount: 200)
}
