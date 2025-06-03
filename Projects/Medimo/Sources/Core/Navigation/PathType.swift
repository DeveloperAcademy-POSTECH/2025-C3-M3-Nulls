//
//  PathType.swift
//  Projects
//
//  Created by 김현기 on 6/2/25.
//

import SwiftUI

enum PathType: Hashable {
    // 단어장
    case GlossaryDetail(glossary: Glossary)
    // 학습
    case StudyTermList(glossary: Glossary),
         StudyTest(glossary: Glossary),
         ReviewTest(glossary: Glossary),
         TestCompletion
}
