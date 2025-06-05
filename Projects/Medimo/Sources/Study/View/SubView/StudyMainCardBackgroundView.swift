//
//  StudyMainCardBackgroundView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyMainCardBackgroundView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 28)
            .inset(by: 2)
            .fill(AppColor.white.opacity(0.3))
            .stroke(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            AppColor.skyPink,
                            AppColor.skyBlue
                        ]
                    ),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ),
                lineWidth: 4
            )
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .inset(by: 4)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    AppColor.white.opacity(0.2),
                                    AppColor.white.opacity(0)
                                ]
                            ),
                            startPoint: .topTrailing, endPoint: .bottomLeading
                        )
                    )
            )
    }
}

#Preview {
    StudyMainCardBackgroundView()
}
