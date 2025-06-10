
//
//  DictionaryViewModel.swift
//  Medimo
//
//  Created by bear on 6/2/25.
//

import CoreData
import Foundation
import Observation
import SwiftUI

@Observable
class DictionaryViewModel {
    let coreDataManager = CoreDataManager.shared

    var searchText: String = ""

    var term: [Term] = []
    var filteredTerms: [Term] {
        return term.filter {
            searchText.isEmpty || ($0.spelling?.localizedCaseInsensitiveContains(searchText) ?? false)
        }
    }

    var selectedTerm: Term?

    init(terms: [Term] = []) {
        term = terms
        fetchTerms(context: coreDataManager.context)
    }

    func fetchTerms(context: NSManagedObjectContext) {
        let request: NSFetchRequest<Term> = Term.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Term.spelling, ascending: true)]

        do {
            let fetchedTerms = try context.fetch(request)
            var seenSpellings = Set<String>()
            var uniqueTerms: [Term] = []

            for t in fetchedTerms {
                if let spelling = t.spelling, !seenSpellings.contains(spelling) {
                    uniqueTerms.append(t)
                    seenSpellings.insert(spelling)
                }
            }
            term = uniqueTerms
        } catch {
            #if DEBUG
                print("Failed to fetch terms: \(error)")
            #endif
        }
    }
}
