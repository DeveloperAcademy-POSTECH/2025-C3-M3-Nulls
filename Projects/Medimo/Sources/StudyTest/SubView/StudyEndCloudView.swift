//
//  StudyEndCloudView.swift
//  Medimo
//
//  Created by bear on 6/6/25.
//

import SwiftUI

struct StudyEndCloudView: View {
    var body: some View {
        
        Spacer()
        ZStack {
            LinearGradient(colors: [AppColor.skyPink.opacity(0.3), AppColor.skyPink], startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .ignoresSafeArea(edges: .bottom)
            
            Image("cloudImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

#Preview {
    StudyEndCloudView()
}
