//
//  StudyEndCountView.swift
//  Medimo
//
//  Created by bear on 6/6/25.
//

import SwiftUI

struct StudyEndCountView: View {
    var body: some View {
        ZStack {
            
            Image("endcloud")
                .resizable()
                .frame(width: 214, height: 186)
                .padding(.bottom, 10)
            
            VStack {
                Text("오늘 학습한 용어")
                    .font(.body)
                    .foregroundStyle(AppColor.grey4)
                    .padding(.bottom, 15)
                    
                Text("22개")
                    .font(.largeTitle)
                    .foregroundStyle(AppColor.navy)
            }
            
        }
    }
}

#Preview {
    StudyEndCountView()
}
