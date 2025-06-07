//
//  StudyTermListViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import CoreData
import Foundation
import Observation

@Observable
class StudyCardViewModel: ObservableObject {
    func cardPosition(for index: Int, currentIndex: Int?) -> CardBackgroundModifier.CardPosition {
        if index == currentIndex {
            return .center
        } else if index < (currentIndex ?? 0) {
            return .left
        } else {
            return .right
        }
    }
}
