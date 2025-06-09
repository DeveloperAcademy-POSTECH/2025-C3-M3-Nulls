//
//  iCloudStatusOverlay.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//

import CloudKit
import SwiftUI

struct iCloudStatusOverlay: View {
    var accountStatus: CKAccountStatus

    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: "icloud.slash")
                    .resizable()
                    .frame(width: 60, height: 48)
                    .foregroundColor(.white)
                Text(message(for: accountStatus))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Button(action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("iCloud 활성화하러 가기")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
            }
            .padding(40)
            .background(Color(.systemGray6).opacity(0.95))
            .cornerRadius(24)
            .shadow(radius: 20)
            .padding(.horizontal, 32)
        }
    }

    private func message(for status: CKAccountStatus) -> String {
        switch status {
        case .available:
            return ""
        case .noAccount:
            return "이 앱은 iCloud 계정이 필요합니다.\n설정에서 iCloud에 로그인해 주세요."
        case .restricted:
            return "iCloud 사용이 제한되어 있습니다.\n관리자에게 문의하세요."
        case .temporarilyUnavailable:
            return "iCloud 서비스가 일시적으로 사용 불가입니다.\n잠시 후 다시 시도해 주세요."
        case .couldNotDetermine:
            return "iCloud 계정 상태를 확인할 수 없습니다.\n네트워크 연결을 확인해 주세요."
        @unknown default:
            return "알 수 없는 iCloud 오류가 발생했습니다."
        }
    }
}
