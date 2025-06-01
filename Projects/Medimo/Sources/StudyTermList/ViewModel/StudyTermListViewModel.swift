//
//  StudyTermListViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import Foundation
import CoreData
import Observation

@Observable
class StudyTermListViewModel {
    var studyTerms: [Term] = []
    var glossary: Glossary
    var splitSize: Int
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext, glossary: Glossary, splitSize: Int) {
        self.context = context
        self.glossary = glossary
        self.splitSize = splitSize
        fetchStudyTerms()
    }
    
    func fetchStudyTerms() {
        let request: NSFetchRequest<Term> = Term.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Term.spelling, ascending: true)]
        request.predicate = NSPredicate(format: "ANY glossarys == %@", glossary)
        request.fetchLimit = splitSize
        
        do {
            studyTerms = try context.fetch(request)
        } catch {
            #if DEBUG
            print("Failed to fetch studyTerms: \(error)")
            #endif
        }
    }
}
