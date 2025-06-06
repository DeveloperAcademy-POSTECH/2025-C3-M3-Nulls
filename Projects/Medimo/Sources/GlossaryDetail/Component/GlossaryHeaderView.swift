//
//  GlossaryHeaderView.swift
//  Projects
//
//  Created by Ell Han on 6/5/25.
//

import SwiftUI

struct GlossaryHeaderView: View {
    let title: String
    let scrollOffset: CGFloat

    var body: some View {
        ZStack(alignment: .bottom) {
            AppColor.secondarySystemFill

            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 10) {
                        Button(action: {
                            // Back action here
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20, weight: .medium))
                        }
                        Text(title)
                            .font(.largeTitle)
                    }
                    .foregroundStyle(AppColor.textColor)
                    .padding(.leading, 16)
                    .padding(.bottom, 40)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 110) {
                            Text("마지막 학습일 2025.05.30 (금)")
                                .font(.caption)
                                .foregroundStyle(AppColor.grey4)

                            HStack(spacing: 3) {
                                Text("150")
                                    .font(.body)
                                    .foregroundStyle(AppColor.textColor)

                                Text("/300")
                                    .font(.caption)
                                    .foregroundStyle(AppColor.secondary)
                            }
                        }

                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundStyle(AppColor.grey1)
                                .frame(width: 359, height: 8)
                                .cornerRadius(7)

                            Rectangle()
                                .foregroundStyle(AppColor.secondary)
                                .frame(width: 46, height: 8)
                                .cornerRadius(7)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 16)
                    }
                    .frame(width: 359, alignment: .topLeading)
                    .padding(.horizontal, 17)
                }
            }
        }
        .frame(height: 211)
        //.ignoresSafeArea(edges: .top)
    }
}

#Preview {
    GlossaryHeaderView(title: "신경외과", scrollOffset: 0)
}
