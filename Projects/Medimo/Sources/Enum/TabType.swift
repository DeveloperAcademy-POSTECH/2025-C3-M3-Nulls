//
//  TabType.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

enum TabType: Int, CaseIterable {
    case glossary
    case study
    case dictionary

    var title: String {
        switch self {
        case .glossary: return "단어장"
        case .study: return "학습하기"
        case .dictionary: return "사전"
        }
    }

    var selectedIcon: String {
        switch self {
        case .glossary: return "glossary_selected"
        case .study: return "study_selected"
        case .dictionary: return "dictionary_selected"
        }
    }

    var Icon: String {
        switch self {
        case .glossary: return "glossaryTab"
        case .study: return "studyTab"
        case .dictionary: return "dictionaryTab"
        }
    }
}
