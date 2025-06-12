//
//  StudyTermListViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import CoreData
import Foundation

class StudyCardViewModel: ObservableObject {
    @Published var terms: [Term] = []

    func loadTerms(with context: NSManagedObjectContext, existGlossaryId: Int) {
        StudyManager.shared.setContext(context, existGlossaryId)
        terms = StudyManager.shared.getNextStudyTerms()
    }

    func cardPosition(for idx: Int, currentIndex: Int?) -> CardBackgroundModifier.CardPosition {
        guard let currentIndex = currentIndex else { return .center }
        if idx < currentIndex {
            return .left
        } else if idx > currentIndex {
            return .right
        } else {
            return .center
        }
    }
}
