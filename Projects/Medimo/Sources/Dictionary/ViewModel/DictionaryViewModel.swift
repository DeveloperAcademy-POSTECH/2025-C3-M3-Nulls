
//
//  DictionaryViewModel.swift
//  Medimo
//
//  Created by bear on 6/2/25.
//

import Foundation
import CoreData
import Observation

@Observable
class DictionaryViewModel {
    var term: [Term]
    
    init(context: NSManagedObjectContext, terms: [Term] = []) {
        self.term = terms
        fetchTerms(context: context)
    }
    
    func fetchTerms(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Term> = Term.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Term.spelling, ascending: true)]
        
        do {
            term = try context.fetch(request)
        } catch {
            #if DEBUG
            print("Failed to fetch terms: \(error)")
            #endif
        }
    }
}
