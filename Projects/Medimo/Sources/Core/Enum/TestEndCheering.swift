//
//  TestEndCheering.swift
//  Projects
//
//  Created by 이서현 on 6/10/25.
//

import SwiftUI

enum LearningType {
    case study
    case review
}

enum TestEndCheering {
    static let topMessages: [LearningType: [String]] = [
        .study: [
            "배움이 쌓이고 있어요.",
            "학습왕이시네요!",
            "한 걸음 더 나아가셨네요!",
            "꾸준함이 답이에요.",
            "어제보다 더 알게 되었어요."
        ],
        .review: [
            "복습의 왕이시네요!",
            "실력이 쌓이고 있어요",
            "완전히 내 것이네요!",
            "복습까지 했다는 건 진짜예요",
            "암기력은 반복에서 나와요",
            "복습은 고수의 루틴이에요",
            "암기는 복습이 더 중요해요.",
            "반복학습을 통한 확실한 공부!"
        ]
    ]
    
    static let bottomMessages: [LearningType: [String]] = [
        .study: [
            "잘 하고 있어요!",
            "학습 완주 성공!",
            "충분히 잘 하고 있어요!"
        ],
        .review: [
            "오늘 할 일 달성!",
            "대단해요!",
            "오늘도 고생했어요!"
        ]
    ]
    
    static func randomTopMessage(for type: LearningType) -> String {
        topMessages[type]?.randomElement() ?? ""
    }
    
    static func randomBottomMessage(for type: LearningType) -> String {
        bottomMessages[type]?.randomElement() ?? ""
    }
}
