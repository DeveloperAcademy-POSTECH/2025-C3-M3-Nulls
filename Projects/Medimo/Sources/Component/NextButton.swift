//
//  NextButton.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct NextButton: View {
    var buttonText: String
    
    var body: some View {
        Button(buttonText) {
            //action
        }
        .font(.body)
        .padding(.vertical, 22)
        .frame(maxWidth: .infinity)
        .background(AppColor.primary)
        .foregroundStyle(AppColor.systemBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4)
    }
}

#Preview {
    NextButton(buttonText: "Next")
}
