//
//  ReviewStartButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct ReviewStartButtonView: View {
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Spacer()
                    Image("cloudBottom")
                        .resizable()
                        .scaledToFill()
                        .rotationEffect(Angle(degrees: -30))
                        .frame(width: 186, height: 60)
                        .offset(x: 30, y: 18)
                        .clipped()
                }
                HStack {
                    Text("복습하기")
                        .font(.headline)
                        .foregroundStyle(AppColor.primaryPink)
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
                    .stroke(AppColor.pink, lineWidth: 2)
                    .frame(height: 60)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReviewStartButtonView(action: {})
}
