//
//  StudyCalendarCardView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI

struct StudyCalendarCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(AppColor.white.opacity(0.9))
                .shadow(
                    color: Color(
                        uiColor: UIColor(
                            red: 164/255,
                            green: 193/255,
                            blue: 247/255,
                            alpha: 0.45
                        )
                    ),
                    radius: 10, x: 0, y: 2
                )
            VStack {
                HStack {
                    Text("나의 학습 캘린더")
                        .font(.body)
                    Spacer()
                    Image("chevron-right")
                        .resizable()
                        .frame(width: 21, height: 21)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 26)
        }
    }
}

#Preview {
    ScrollView {
        StudyCalendarCardView()
    }
}
