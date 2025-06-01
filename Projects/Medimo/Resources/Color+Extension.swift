//
//  Color+Extension.swift
//  Projects
//
//  Created by 이서현 on 6/2/25.
//

import SwiftUI

extension Color {
    /// Hex 코드로부터 Color를 생성 예: Color(hex: "#1C367D")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

    static let navy = Color(hex: "1C367D")
}
