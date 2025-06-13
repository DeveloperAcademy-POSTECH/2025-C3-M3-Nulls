//
//  GlossaryHeaderView.swift
//  Projects
//
//  Created by Ell Han on 6/5/25.
//

import SwiftUI

struct GlossaryHeaderView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let title: String
    let lastStudiedAt: Date?
    let currentCount: Int
    let totalCount: Int
    let scrollOffset: CGFloat

    func lastStudiedAtString(_ date: Date?) -> String {
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd (E)"
            return formatter.string(from: date)
        } else {
            return "-"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 40) {
                HStack(spacing: 10) {
                    Button(action: {
                        navigationManager.glossaryPath.removeLast()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 20, weight: .medium))
                    }
                    Text(title)
                        .font(.largeTitle)
                }
                .foregroundStyle(AppColor.textColor)
                .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("마지막 학습일: \(lastStudiedAtString(lastStudiedAt))")
                            .font(.caption)
                            .foregroundStyle(AppColor.grey4)
                        Spacer()
                        HStack(spacing: 3) {
                            Text("\(currentCount)")
                                .font(.body)
                                .foregroundStyle(AppColor.label)

                            Text("/\(totalCount)")
                                .font(.caption)
                                .foregroundStyle(AppColor.blue)
                        }
                        .padding(.horizontal, 4)
                    }
                    Capsule()
                        .fill(AppColor.grey1)
                        .frame(height: 8)
                        .overlay(
                            GeometryReader { geometry in
                                Capsule()
                                    .fill(AppColor.blue)
                                    .frame(width: geometry.size.width * CGFloat(currentCount) / CGFloat(totalCount), height: 8)
                            }
                            .clipShape(Capsule())
                        )
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 90)
        .padding(.bottom, 16)
        .background(AppColor.secondarySystemFill)
    }
}

#Preview {
    GlossaryHeaderView(
        title: "신경외과",
        lastStudiedAt: Date(),
        currentCount: 1,
        totalCount: 5,
        scrollOffset: 0
    )
}
