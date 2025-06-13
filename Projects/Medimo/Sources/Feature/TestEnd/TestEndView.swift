//  TestEndView.swift
//  Projects
//
//  Created by 이서현 on 6/7/25.
//

import SwiftUI

struct TestEndView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let studyManager: StudyManager = .shared

    @Binding var isStudyInProgress: Bool
    var index: Int

    @Binding var learningType: LearningType

    var top: String {
        TestEndCheering.randomTopMessage(for: learningType)
    }

    var bottom: String {
        TestEndCheering.randomBottomMessage(for: learningType)
    }

    var body: some View {
        VStack {
            Spacer(minLength: 140)

            Text("어제보다 더 알게 되었어요")
                .font(.body)
                .foregroundStyle(AppColor.grey4)
                .padding(.bottom, 17)
            Text("잘하고 있어요!")
                .font(.title)
                .foregroundStyle(AppColor.grey4)
                .padding(.bottom, 54)

            ZStack {
                Image("cloudCenter")
                VStack {
                    Text("오늘 학습한 용어")
                        .font(.body)
                        .foregroundStyle(AppColor.grey4)
                        .padding(.bottom, 10)

                    Text("\(index + 1)개")
                        .font(.largeTitle)
                        .foregroundStyle(AppColor.navy)
                }
            }

            Spacer()
            ZStack {
                VStack {
                    ZStack {
                        Image("cloudBottom")
                        Image("character1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 70)
                            .offset(y: -90)
                    }
                    .padding(.bottom, -60)

                    Image("pinkBottom")
                }

                NextButton(
                    buttonText: learningType == .study ? "학습 완료하기" : "복습 완료하기",
                    action: {
                        studyManager.countCurrentStreakAndSave()
                        withAnimation(.none) {
                            navigationManager.studyPath = []
                            isStudyInProgress = false
                        }
                    }
                )
                .padding(70)
                .offset(y: 100)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.bgColor)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
