//
//  GlossaryListViewModel.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import Foundation
import CoreData
import Observation

@Observable
class GlossaryListViewModel {
    var glossaries: [Glossary]
    
    var moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, glossaries: [Glossary] = []) {
        self.glossaries = glossaries
        self.moc = context
        fetchGlossaries(context: context)
    }
    
    func fetchGlossaries(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Glossary> = Glossary.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Glossary.title, ascending: true)]
        
        do {
            glossaries = try context.fetch(request)
        } catch {
            #if DEBUG
            print("Failed to fetch glossaries: \(error)")
            #endif
        }
    }
    
    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? moc.fetch(fetchRequest)) ?? []

        return users.first ?? User(context: moc)
    }
}
