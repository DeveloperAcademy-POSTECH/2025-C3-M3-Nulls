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
                    .ignoresSafeArea(edges: .bottom)
            }

            VStack {
                HStack(alignment: .center) {
                    Button {
                        navigationManager.studyPath.removeFirst()
                    } label: {
                        Image("chevron-left")
                    }

                    Spacer()
                    Text("캘린더")
                    Spacer()
                    Image("download")
                }
                .padding(.horizontal, 16)

                HStack {
                    Spacer()
                    VStack {
                        Text("960개")
                        Text("외운 단어 수")
                    }
                    Spacer()
                    VStack {
                        Text("18일")
                        Text("최대 연속 학습")
                    }
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(16)
                .padding(.vertical, 9)

                // 달력
                
                
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    StudyCalendarView()
}
