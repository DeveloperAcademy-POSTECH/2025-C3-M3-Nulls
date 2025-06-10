//
//  CorrectAnswer.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct WrongAnswer: View {
    var correctAnswer: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            VStack(alignment: .leading) {
                HStack {
                    Image("x")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(AppColor.skyPink)
                        .padding(6)
                        .background(AppColor.hotPink)
                        .cornerRadius(50)
                        .padding(.trailing, 25)
                    
                    Text("오답입니다!")
                        .font(.caption)
                        .foregroundStyle(AppColor.hotPink)
                    Spacer()
                }
                .padding(.bottom, 16)
                
                HStack {
                    Text("정답 :")
                        .font(.caption)
                        .foregroundStyle(AppColor.hotPink)
                        .padding(.trailing, 10)
                    Text(correctAnswer)
                        .font(.headlineEng)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(20)
            .background(AppColor.skyPink)
            .cornerRadius(15)
            
            Image("character4")
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y: -20)
        }
    }
}

#Preview {
    WrongAnswer(correctAnswer: "Electrocardiogram Moore")
        .padding()
        .background(Color.white)
}
