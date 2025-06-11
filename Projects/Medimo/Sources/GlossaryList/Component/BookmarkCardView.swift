//
//  BookmarkCardView.swift
//  Medimo
//
//  Created by 김현기 on 6/11/25.
//

import SwiftUI

struct BookmarkCardView: View {
    let title: String
    let totalCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text(title)
                    .font(.body)
                    .kerning(0.1)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(AppColor.label)

                Spacer()

                Image("bookmark.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }

            Capsule()
                .fill(AppColor.secondarySystemFill)
                .frame(height: 8)
                .opacity(0.0)

            HStack(alignment: .bottom, spacing: 4) {
                Spacer()

                Text("\(totalCount)")
                    .font(.bodyEng)
                    .foregroundColor(AppColor.label)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16))
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: AppColor.primary.opacity(0.35), radius: 2.5, x: 0, y: 2)
    }
}

#Preview {
    BookmarkCardView(title: "북마크", totalCount: 10)
}
