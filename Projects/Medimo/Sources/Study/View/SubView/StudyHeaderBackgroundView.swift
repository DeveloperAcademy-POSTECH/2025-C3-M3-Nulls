//
//  StudyHeaderBackgroundView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import SwiftUI

struct StudyHeaderBackgroundView: View {
    var body: some View {
        VStack {
            LinearGradient(
                colors: [
                    Color(AppColor.skyBlue),
                    Color(AppColor.bgColor),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.65),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .frame(height: 250)
            Spacer()
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            Color.clear
        }
        .background(StudyHeaderBackgroundView())
    }
}
