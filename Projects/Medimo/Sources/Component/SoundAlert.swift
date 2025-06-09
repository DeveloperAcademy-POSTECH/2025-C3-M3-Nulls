//
//  SoundAlert.swift
//  Projects
//
//  Created by 이서현 on 6/9/25.
//

import SwiftUI

public struct SoundAlert: View {
    public var body: some View {
        HStack {
            Image("alert-triangle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .foregroundStyle(AppColor.hotPink)
                .padding(.horizontal, 16)
            Text("볼륨이 낮습니다. 소리를 높여주세요!")
                .font(.caption)
                .foregroundStyle(AppColor.label)
                .padding(.vertical, 16)
            Spacer()
        }
        .background(AppColor.skyPink)
        .cornerRadius(15)
    }
}

#Preview {
    SoundAlert()
}
