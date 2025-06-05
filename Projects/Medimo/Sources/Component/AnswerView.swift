//
//  AnswerTextBox.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct AnswerView: View {
    let correctAnswer: String
    @State var answer: String
    @State private var isAnswered: Bool = false
    @State private var isCorrect: Bool = false
    let buttonText: String
    
    var body: some View {
        VStack {
            HStack {
                TextField("정답 입력하기", text: $answer)
                    .font(.bodyEng)
                    .foregroundStyle(AppColor.grey3)
                    .padding(.horizontal, 8)
                    .disabled(isAnswered)
                
                Button(action: {
                    isCorrect = answer == correctAnswer
                    isAnswered = true
                }) {
                    Image("corner-down-left")
                        .renderingMode(.template)
                        .foregroundStyle(AppColor.white)
                }
                .padding(12)
                .background(AppColor.navy)
                .cornerRadius(16)
                .disabled(answer.isEmpty || isAnswered)
            }
            .padding(8)
            .background(AppColor.white)
            .cornerRadius(15)
            
            if isAnswered {
                if isCorrect {
                    CorrectAnswer()
                    
                } else {
                    WrongAnswer(correctAnswer: correctAnswer)
                }
                Spacer()
                
                NextButton(buttonText: buttonText)
            } else {
                Spacer()
            }
            
        }
    }
}

#Preview {
    AnswerView(correctAnswer: "test", answer: "test", buttonText: "Next")
}
