//
//  SplashView.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.managedObjectContext) private var moc
    let coreDataManager = CoreDataManager.shared

    var body: some View {
        ZStack {
            Image("SplashScreen")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            if coreDataManager.needsInitialCloudKitFetch(context: moc) {
                VStack {
                    Spacer()

                    HStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: AppColor.label))
                            .frame(width: 24, height: 24)
                        Text("초기 데이터를 가져오고 있어요...")
                            .foregroundStyle(AppColor.label)
                    }
                }
                .padding(.bottom, 64)
            }
        }
    }
}

#Preview {
    SplashView()
}
