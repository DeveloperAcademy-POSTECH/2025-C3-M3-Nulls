//
//  StudyHeaderView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyHeaderView: View {
    @State var streak: Int

    var body: some View {
        Group {
            if streak == 0 {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("환영해요 👋")
                            .font(.largeTitle)
                            .foregroundStyle(AppColor.label)
                        Spacer()
                    }
                    HStack {
                        Text("오늘부터 새로운 시작이에요! 힘내세요! 🚀")
                            .font(.title)
                            .foregroundStyle(AppColor.label)
                        Spacer()
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("\(streak)일째")
                            .font(.largeTitle)
                            .foregroundStyle(AppColor.label)
                        Spacer()
                    }
                    HStack {
                        Text("학습중이에요! 화이팅!! 🎉")
                            .font(.title)
                            .foregroundStyle(AppColor.label)
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 82)
    }
}

#Preview {
    let streak = 5
    ScrollView {
        StudyHeaderView(streak: streak)
    }
    .ignoresSafeArea(edges: .top)
}
