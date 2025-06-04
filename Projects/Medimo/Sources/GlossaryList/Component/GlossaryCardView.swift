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
        VStack(alignment: .leading, spacing: 25) {
            Text(title)
                .font(.custom("S-Core Dream", size: 17))
                .kerning(0.1)
                .foregroundColor(Color("MM_Navy"))
            
            //대충 더미용... 프로그레스 바
            Capsule()
                .fill(Color("MM_Skyblue"))
                .frame(height: 8)
                .overlay(
                    GeometryReader { geometry in
                        Capsule()
                            .fill(Color("MM_Blue"))
                            .frame(width: geometry.size.width * 0.3, height: 8)
                    }
                    .clipShape(Capsule())
                )
            HStack(spacing: 5) {
                Text("\(String(format: "%02d", currentCount))")
                    .font(.custom("Gmarket Sans", size: 17).weight(.medium))
                    .foregroundColor(Color("MM_Navy"))

                Text("/\(totalCount)")
                    .font(.custom("Gmarket Sans", size: 13).weight(.medium))
                    .foregroundColor(Color("MM_Skyblue"))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .frame(width: 170, height: 120, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color("MM_Navy").opacity(0.35), radius: 2.5, x: 0, y: 2)
    }
}

#Preview {
    GlossaryCardView(title: "북마크", currentCount: 1, totalCount: 200)
}
