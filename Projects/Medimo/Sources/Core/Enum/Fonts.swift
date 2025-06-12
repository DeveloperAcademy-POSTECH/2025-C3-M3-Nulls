//
//  Font.swift
//  Projects
//
//  Created by 이서현 on 6/3/25.
//

import SwiftUI

enum Fonts {
    case eng_bold
    case eng_medium
    case kor_5Medium
    case kor_6Bold
    case kor_7ExtraBold
    
    var name: String {
        switch self {
        case .eng_bold:
            return "GmarketSansBold"
        case .eng_medium:
            return "GmarketSansMedium"
        case .kor_5Medium:
            return "SCDream5"
        case .kor_6Bold:
            return "SCDream6"
        case .kor_7ExtraBold:
            return "SCDream7"
        }
    }
    
    func font(size: CGFloat) -> Font {
        Font.custom(self.name, size: size)
    }
}
