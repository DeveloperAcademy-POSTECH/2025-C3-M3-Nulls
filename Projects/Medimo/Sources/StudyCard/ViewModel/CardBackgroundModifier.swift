//
//  CardBackgroundModifier.swift
//  Medimo
//
//  Created by bear on 6/5/25.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    enum CardPosition {
        case center, left, right
    }

    let position: CardPosition

    func body(content: Content) -> some View {
        content
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(colorForPosition(position))
//            )
    }
}
