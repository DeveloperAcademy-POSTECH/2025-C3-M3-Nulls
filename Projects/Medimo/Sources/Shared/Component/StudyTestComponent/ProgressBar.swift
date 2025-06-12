//
//  ProgressBar.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct ProgressBar: View {
    let index: Int
    let total: Int
    var format: String = "%02d"

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 7)
                    .fill(AppColor.skyBlue)
                
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 7)
                        .fill(AppColor.blue)
                        .frame(
                            width: geo.size.width * CGFloat(index) / CGFloat(max(total, 1))
                        )
                }
            }
            .frame(height: 8)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .padding(.trailing, 12)
            
            Text("\(String(format: format, index)) / \(total)")
                .font(.caption)
                .foregroundStyle(AppColor.navy)
        }
    }
}

#Preview {
    ProgressBar(index: 1, total: 15)
        .padding()
}
