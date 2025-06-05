//
//  AnswerTextBox.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct AnswerTextBox: View {
    @State var answer: String
    
    var body: some View {
        HStack {
            TextField("정답 입력하기", text: $answer)
                .font(.bodyEng)
                .foregroundStyle(AppColor.grey3)
                .padding(.horizontal, 8)
            Button(action: {
                // action
            }) {
                Image("corner-down-left")
                    .renderingMode(.template)
                    .foregroundStyle(AppColor.white)
            }
            .padding(12)
            .background(AppColor.navy)
            .cornerRadius(16)
        }
        .padding(8)
        .background(AppColor.white)
        .cornerRadius(15)
    }

}

#Preview {
    AnswerTextBox(answer: "")
}
