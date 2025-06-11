//
//  PathType.swift
//  Projects
//
//  Created by 김현기 on 6/2/25.
//

import SwiftUI

enum PathType: Hashable {
    // 단어장
    case GlossaryDetail(glossary: Glossary, currenctCount: Int, totalCount: Int)
    case BookmarkDetail

    // 학습
    case StudyCard
    case StudyTest(terms: [Term])
    case ReviewTest

    case StudyCalendar

    case TestCompletion(index: Int)
}
