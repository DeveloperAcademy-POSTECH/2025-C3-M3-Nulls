//
//  StudyViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import Foundation
import CoreData

@Observable
class StudyViewModel {
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    var studyingGlossary: Glossary {
        return StudyManager.shared.studyingGlossary!
    }
    
    var streak: Int {
        Int(user.currentStreak)
    }
    
    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? moc.fetch(fetchRequest)) ?? []

        return users.first ?? User(context: moc)
    }
}
