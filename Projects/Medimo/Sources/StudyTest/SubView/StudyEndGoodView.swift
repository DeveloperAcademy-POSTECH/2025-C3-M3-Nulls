//
//  StudyEndGoodView.swift
//  Medimo
//
//  Created by bear on 6/6/25.
//

import SwiftUI

struct StudyEndGoodView: View {
    var body: some View {
        Text("어제보다 더 알게 되었어요.")
            .font(.body)
            .foregroundStyle(AppColor.grey4)
            .padding(17)
        
        Text("잘하고 있어요!")
            .font(.title)
            .foregroundStyle(AppColor.grey4)
    }
}

#Preview {
    StudyEndGoodView()
}
