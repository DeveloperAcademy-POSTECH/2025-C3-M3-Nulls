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
    var glossaries: [Glossary] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchGlossaries()
    }
    
    func fetchGlossaries() {
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
}
