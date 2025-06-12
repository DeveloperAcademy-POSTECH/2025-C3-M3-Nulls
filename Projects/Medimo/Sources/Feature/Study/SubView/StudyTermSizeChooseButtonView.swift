//
//  StudyTermSizeChooseButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import SwiftUI

struct StudyTermSizeChooseButtonView: View {
    let studyManager = StudyManager.shared
    @State private var showDialog = false

    var body: some View {
        Button {
            showDialog = true
        } label: {
            HStack(spacing: 10) {
                Text("하루 목표: ")
                    .font(.caption)
                    .foregroundStyle(AppColor.secondaryLabel)
                HStack(spacing: 6) {
                    Text("\(studyManager.studyTermSize)개")
                        .font(.caption)
                        .foregroundStyle(AppColor.primary)
                    Image("chevron-down")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(AppColor.primary)
                }
            }
            .padding(.vertical, 4)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(AppColor.grey3),
                alignment: .bottom
            )
        }
        .confirmationDialog(
            Text("오늘의 학습 / 복습 단어 수"),
            isPresented: $showDialog,
            titleVisibility: .visible
        ) {
            ForEach(StudyTermSizeOption.allCases, id: \.self) { option in
                Button("\(option.rawValue)개") {
                    studyManager.studyTermSize = option.rawValue
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("오늘의 목표치를 달성해 보아요!")
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext
    StudyManager.shared.setContext(context, 0)

    return StudyTermSizeChooseButtonView()
}
