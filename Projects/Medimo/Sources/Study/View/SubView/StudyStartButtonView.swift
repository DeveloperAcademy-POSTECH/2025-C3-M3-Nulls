//
//  StudyStartButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyStartButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Spacer()
                    Image("character1")
                        .resizable()
                        .scaledToFill()
                        .rotationEffect(Angle(degrees: -30))
                        .offset(x: 30, y: 8)
                        .frame(width: 136, height: 60)
                        .clipped()
                }
                HStack {
                    Text("학습하기")
                        .font(.headline)
                        .foregroundStyle(AppColor.primary)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
            .background(AppColor.white)
            .mask(
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 60)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 1)
                    .stroke(AppColor.blue, lineWidth: 2)
                    .frame(height: 60)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    StudyStartButtonView(action: {})
}
