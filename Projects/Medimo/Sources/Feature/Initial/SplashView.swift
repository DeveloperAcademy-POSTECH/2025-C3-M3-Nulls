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

    @State private var isLoading = true
    @State private var loadError: String?

    var body: some View {
        ZStack {
            if isLoading {
                ZStack {
                    Image("LaunchScreen")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        HStack {
                            ProgressView()
                            Text("데이터 불러오는 중...")
                        }
                        if coreDataManager.needsInitialCloudKitFetch(context: coreDataManager.context) {
                            Text("앱 초기 실행 시 시간이 걸릴 수 있습니다.")
                                .padding(.bottom, 50)
                        } else {
                            Text("")
                                .padding(.bottom, 50)
                        }
                    }
                }
                .transition(.opacity)
            } else if let error = loadError {
                Text("에러: \(error)")
                    .transition(.opacity)
            } else {
                ContentView(context: coreDataManager.context)
                    .environment(\.managedObjectContext, coreDataManager.context)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isLoading)
        // onAppear는 그대로 유지
        .onAppear {
            Task {
                let start = Date()
                var result = true

                if coreDataManager.needsInitialCloudKitFetch(context: coreDataManager.context) {
                    result = await coreDataManager.initialize()
                }
                let elapsed = Date().timeIntervalSince(start)
                if elapsed < 1 {
                    try? await Task.sleep(nanoseconds: UInt64((1 - elapsed) * 1_000_000_000))
                }
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if result {
                            isLoading = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
