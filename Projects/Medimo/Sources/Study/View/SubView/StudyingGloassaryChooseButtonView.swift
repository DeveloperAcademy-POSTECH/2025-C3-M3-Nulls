//
//  StudyingGloassaryChooseButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyingGloassaryChooseButtonView: View {
    var body: some View {
        Button {
        
        } label: {
            HStack(spacing: 16) {
                Text("신경외과")
                    .font(.title)
                    .foregroundStyle(AppColor.label)
                Image("chevron-down")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}

#Preview {
    StudyingGloassaryChooseButtonView()
}
