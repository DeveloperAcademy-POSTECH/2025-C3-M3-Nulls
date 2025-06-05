//
//  TestTermBox.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct TestTermBox: View {
    var term: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(AppColor.blue)
                .frame(height: 124)
            RoundedRectangle(cornerRadius: 28)
                .fill(AppColor.bgColor)
                .frame(height: 120)
            Text(term)
                .font(.titleEng)
            
        }
    }
}

#Preview {
    TestTermBox(term: "Electrocardiogram")
        .padding()
        .background(Color.white)
}
