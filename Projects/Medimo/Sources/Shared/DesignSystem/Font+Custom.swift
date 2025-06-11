//
//  Font+Custom.swift
//  Projects
//
//  Created by 양시준 on 6/3/25.
//

import SwiftUI

extension Font {
    static let largeTitle = Font.custom("S-CoreDream-7ExtraBold", size: 32, relativeTo: .largeTitle) // MM_H1
    static let title = Font.custom("S-CoreDream-6Bold", size: 24, relativeTo: .title) // MM_H2
    static let headline = Font.custom("S-CoreDream-6Bold", size: 17, relativeTo: .headline)
    static let body = Font.custom("S-CoreDream-5Medium", size: 17, relativeTo: .body) // MM_Pr
    static let subheadline = Font.custom("S-CoreDream-6Bold", size: 13, relativeTo: .subheadline)
    static let caption = Font.custom("S-CoreDream-5Medium", size: 13, relativeTo: .caption) // MM_AT
    static let caption2 = Font.custom("S-CoreDream-5Medium", size: 13, relativeTo: .caption)
    
    static let largeTitleEng = Font.custom("Gmarket Sans Bold", size: 32, relativeTo: .largeTitle) // MM_EH1
    static let titleEng = Font.custom("Gmarket Sans Bold", size: 24, relativeTo: .title) // MM_EH2
    static let headlineEng = Font.custom("Gmarket Sans Bold", size: 17, relativeTo: .headline) // MM_EH3
    static let bodyEng = Font.custom("Gmarket Sans Medium", size: 17, relativeTo: .body) // MM_EPr
    static let subheadlineEng = Font.custom("Gmarket Sans Bold", size: 13, relativeTo: .subheadline) // MM_Eat_B
    static let captionEng = Font.custom("Gmarket Sans Medium", size: 13, relativeTo: .caption) // MM_EAt
}
