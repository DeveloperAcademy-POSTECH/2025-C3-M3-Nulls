//
//  TopRoundedRectangle.swift
//  Projects
//
//  Created by 김현기 on 6/6/25.
//

import SwiftUI

struct TopRoundedRectangle: Shape {
    var radius: CGFloat = 20

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
