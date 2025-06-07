//
//  TestEndView.swift
//  Projects
//
//  Created by 이서현 on 6/7/25.
//

import SwiftUI

 struct TestEndView: View {
     @Binding var index: Int

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

                     Text("\(index)개")
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

                 // TODO: 메인 화면으로 이동 연결
                 NextButton(buttonText: "학습 종료하기", action: {
                     print("메인 화면으로 이동")
                 })
                 .padding(70)
                 .offset(y: 100)
             }
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(AppColor.bgColor)
         .ignoresSafeArea()
     }
 }

 #Preview {
     TestEndView(index: .constant(22))
 }
