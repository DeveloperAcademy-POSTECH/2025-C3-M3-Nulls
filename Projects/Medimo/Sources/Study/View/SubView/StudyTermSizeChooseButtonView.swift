//
//  StudyTermSizeChooseButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyTermSizeChooseButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 10) {
                Text("하루 목표: ")
                    .font(.caption)
                    .foregroundStyle(AppColor.secondaryLabel)
                HStack(spacing: 6) {
                    Text("30개")
                        .font(.caption)
                        .foregroundStyle(AppColor.primary)
                    Image("chevron-down")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(AppColor.primary)
                }
            }
            .padding(.vertical, 4)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(AppColor.grey3),
                alignment: .bottom
            )
        }
    }
}

#Preview {
    StudyTermSizeChooseButtonView()
}
