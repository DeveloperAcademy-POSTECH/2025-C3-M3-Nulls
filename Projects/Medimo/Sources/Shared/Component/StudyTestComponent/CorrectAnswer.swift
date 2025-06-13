//
//  CorrectAnswer.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct CorrectAnswer: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Image("circle")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(AppColor.skyBlue)
                    .padding(8)
                    .background(AppColor.navy)
                    .cornerRadius(50)
                    .padding(.trailing, 25)
                
                Text("정답입니다!")
                    .font(.caption)
                    .foregroundStyle(AppColor.navy)
                Spacer()
            }
            .padding(20)
            .background(AppColor.skyBlue)
            .cornerRadius(15)
            
            Image("character2")
                .resizable()
                .frame(width: 88, height: 88)
        }
    }
}

#Preview {
    CorrectAnswer()
}
