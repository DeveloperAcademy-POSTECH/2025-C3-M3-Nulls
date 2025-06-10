
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
            term = try context.fetch(request)
        } catch {
            #if DEBUG
                print("Failed to fetch terms: \(error)")
            #endif
        }
    }
}
