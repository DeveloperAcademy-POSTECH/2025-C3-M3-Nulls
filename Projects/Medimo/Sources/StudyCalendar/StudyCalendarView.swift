//
//  StudyCalendarView.swift
//  Medimo
//
//  Created by 김현기 on 6/6/25.
//

import SwiftUI

struct StudyCalendarView: View {
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        ZStack {
            AppColor.bgColor
                .ignoresSafeArea(.all)

            VStack {
                Spacer()
                Image("cloudImage")
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        navigationManager.studyPath.removeLast()
                    } label: {
                        Image("chevron-left")
                            .foregroundStyle(AppColor.blue)
                    }
                    Spacer()
                    Text("캘린더")
                        .foregroundStyle(AppColor.navy)
                        .font(.headline)
                    Spacer()
                    Image("download")
                        .foregroundStyle(AppColor.blue)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

                HStack {
                    Spacer()
                    VStack {
                        Text("960개")
                            .font(.title)
                            .foregroundStyle(AppColor.navy)
                            .padding(.bottom, 15)
                        Text("외운 단어 수")
                            .font(.headline)
                            .foregroundStyle(AppColor.grey3)
                    }
                    Spacer(minLength: 75)
                    VStack {
                        Text("18일")
                            .font(.title)
                            .foregroundStyle(AppColor.blue)
                            .padding(.bottom, 15)
                        Text("최대 연속 학습")
                            .font(.headline)
                            .foregroundStyle(AppColor.grey3)
                    }
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                )
                .padding(16)

                // 달력

                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    StudyCalendarView()
        .environmentObject(NavigationManager())
}
