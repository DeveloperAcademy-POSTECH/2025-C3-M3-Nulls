//
//  AnswerTextBox.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import AudioToolbox
import SwiftUI

struct AnswerView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let studyManager: StudyManager = .shared

    let correctAnswer: String
    @Binding var index: Int
    @Binding var termSize: Int

    @State private var answer: String = ""
    @Binding var isAnswered: Bool
    @State private var isCorrect: Bool = false

    @Binding var showSoundAlert: Bool
    @Binding var learningType: LearningType

    @FocusState private var isTextFieldFocused: Bool

    @Binding var term: Term

    @State private var showError: Bool = false

    var buttonText: String

    func clean(_ text: String) -> String {
        return text
            .lowercased()
            .replacingOccurrences(of: "[^a-z가-힣&]", with: "", options: .regularExpression)
    }

    func submitAction() {
        if answer.isEmpty {
            showError = true
            // 진동 발생
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            return
        }
        showError = false

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
                TextField("", text: $answer)
                    .font(.bodyEng)
                    .foregroundStyle(AppColor.label)
                    .padding(.horizontal, 8)
                    .disabled(isAnswered)
                    .submitLabel(.done)
                    .onSubmit { submitAction() }
                    .focused($isTextFieldFocused)
                    .placeholder(when: answer.isEmpty) {
                        Text("정답 입력하기")
                            .font(.bodyEng)
                            .foregroundStyle(AppColor.grey3)
                            .padding(.horizontal, 8)
                    }

                Button(action: {
                    submitAction()
                }) {
                    Image("corner-down-left")
                        .renderingMode(.template)
                        .foregroundStyle(AppColor.white)
                }
                .padding(12)
                .background(showError ? AppColor.hotPink : AppColor.navy)
                .cornerRadius(16)
                .disabled(answer.isEmpty || isAnswered)
            }
            .padding(8)
            .background(showError ? AppColor.skyPink : AppColor.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(showError ? AppColor.hotPink : Color.clear, lineWidth: 1)
            )

            Text("잠깐! 아직 정답을 작성하지 않았어요.")
                .font(.caption)
                .foregroundStyle(AppColor.hotPink)
                .opacity(showError ? 1 : 0)
                .padding(.top, 15)

            if isAnswered {
                if isCorrect {
                    CorrectAnswer()
                        .onAppear {
                            StudyManager.shared.updateReview(of: term, result: .correct)
                        }
                } else {
                    WrongAnswer(correctAnswer: correctAnswer)
                        .onAppear {
                            StudyManager.shared.updateReview(of: term, result: .incorrect)
                        }
                }

                Spacer()

                NextButton(buttonText: buttonText, action: {
                    print("buttonText: \(buttonText), index: \(index), termSize: \(termSize)")
                    if index < termSize - 1 {
                        isAnswered = false
                        isCorrect = false
                        answer = ""
                        index += 1
                    } else {
                        isAnswered = false
                        studyManager.addDateInfoWhenFinished(learningType)
                        if learningType == .study {
                            studyManager.updateGlossaryProgress()
                        }

                        navigationManager.studyPath.append(.TestCompletion(index: index))
                    }
                })
            }
        }
        .onAppear {
            isTextFieldFocused = true
        }
        .onChange(of: index) {
            isTextFieldFocused = true
            showError = false
        }
    }
}
