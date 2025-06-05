//
//  StudyRingView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyRingView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [AppColor.skyPink, AppColor.skyBlue]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .rotationEffect(.degrees(30))
                .frame(width: 250, height: 250)
                .overlay(
                    VStack {
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("240")
                                .font(.custom("Gmarket Sans Bold", size: 48))
                                .foregroundStyle(AppColor.label)
                            Text("/300")
                                .font(.custom("Gmarket Sans Medium", size: 16))
                                .foregroundStyle(AppColor.label)
                                .padding(.bottom, 8)
                        }
                        Text("나의 학습 현황")
                            .font(.caption)
                            .foregroundStyle(AppColor.label)
                    }
                )
            Circle()
                .trim(from: 0.0, to: 240/300)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [AppColor.navy, AppColor.blue]),
                        startPoint: UnitPoint(x: 0.7, y: 0.7),
                        endPoint: UnitPoint(x: -0.7, y: -0.7)
                    ),
                    style: StrokeStyle(lineWidth: 40, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 250, height: 250)
                .background(
                    Circle()
                        .trim(from: 0.0, to: 240/300)
                        .stroke(
                            AppColor.white,
                            style: StrokeStyle(lineWidth: 41, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 250, height: 250)
                        .shadow(color: AppColor.textColor.opacity(0.3), radius: 5, x: 2, y: 4)
                )
        }
    }
}

#Preview {
    StudyRingView()
}
