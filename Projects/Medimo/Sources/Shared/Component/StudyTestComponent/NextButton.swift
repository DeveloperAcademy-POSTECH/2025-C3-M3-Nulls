//
//  NextButton.swift
//  Projects
//
//  Created by 이서현 on 6/6/25.
//

import SwiftUI

struct NextButton: View {
    var buttonText: String
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .font(.body)
                .padding(.vertical, 22)
                .frame(maxWidth: .infinity)
                .background(AppColor.label)
                .foregroundStyle(AppColor.white)
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 2, y: 4)
        }
    }
}

#Preview {
    struct NextButtonAlertPreview: View {
        @State private var showAlert = false

        var body: some View {
            NextButton(buttonText: "Next") {
                showAlert = true
            }
            .alert("Tapped", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
            .padding()
        }
    }

    return NextButtonAlertPreview()
}
