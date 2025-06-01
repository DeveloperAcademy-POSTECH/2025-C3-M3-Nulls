//
//  FlashCardViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import SwiftUI

struct FlashCardViewModel: Identifiable {
    var id: UUID = UUID()
    var question: String
    var answer: String
}
