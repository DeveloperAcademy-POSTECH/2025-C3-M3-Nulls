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
        .padding(.horizontal, 24)
        .padding(.top, 82)
    }
}

#Preview {
    var streak: Int = 5
    ScrollView {
        StudyHeaderView(streak: streak)
    }
    .ignoresSafeArea(edges: .top)
}
