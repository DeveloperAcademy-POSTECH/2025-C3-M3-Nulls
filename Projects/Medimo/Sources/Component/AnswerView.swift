//
//  AnswerTextBox.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct AnswerView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    let correctAnswer: String
    @Binding var index: Int
    @Binding var termSize: Int
    
    @State private var answer: String = ""
    @State private var isAnswered: Bool = false
    @State private var isCorrect: Bool = false
    
    @Binding var isStudyInProgress: Bool
    @Binding var showSoundAlert: Bool
  
    var buttonText: String
    
    func clean(_ text: String) -> String {
        return text
            .lowercased()
            .replacingOccurrences(of: "[^a-z]", with: "", options: .regularExpression)
    }
    
    func submitAction() {
        let trimmedAnswers = correctAnswer
            .split(separator: ",")
            .map { clean(String($0)) }

        let userAnswer = clean(answer)
      
        isCorrect = trimmedAnswers.contains(userAnswer)
        isAnswered = true
        showSoundAlert = false
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("정답 입력하기", text: $answer)
                    .font(.bodyEng)
                    .foregroundStyle(AppColor.grey3)
                    .padding(.horizontal, 8)
                    .disabled(isAnswered)
                    .submitLabel(.done)
                    .onSubmit {
                        submitAction()
                    }

                Button(action: {
                    submitAction()
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
                
                NextButton(buttonText: buttonText, action: {
                    if index < termSize {
                        isAnswered = false
                        isCorrect = false
                        answer = ""
                        index += 1
                    } else {
                        navigationManager.studyPath.append(.TestCompletion(index: index))
                    }
                })
            } else {
//                Spacer()
            }
        }
    }
}

#Preview {
    AnswerView(
        correctAnswer: "abc, def",
        index: .constant(1),
        termSize: .constant(2),
        isStudyInProgress: .constant(true),
        showSoundAlert: Binding.constant(false),
        buttonText: "다음"
    )
    .environmentObject(NavigationManager())
}
