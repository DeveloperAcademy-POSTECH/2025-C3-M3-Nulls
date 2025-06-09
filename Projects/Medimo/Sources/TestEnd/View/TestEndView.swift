//  TestEndView.swift
//  Projects
//
//  Created by 이서현 on 6/7/25.
//

import SwiftUI

struct TestEndView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Binding var isStudyInProgress: Bool
    var index: Int
    
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
                
                NextButton(buttonText: "학습 종료하기", action: {
                    
                    
                    withAnimation {
                        isStudyInProgress = false
                    }
//                    navigationManager.studyPath.removeAll()
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
//
//#Preview {
//    @Previewable @State var isStudyInProgress = true
////    TestEndView(isStudyInProgress: $isStudyInProgress, terms: terms, index: 22)
//}
