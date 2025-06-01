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
    var splitSize = 5
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchStudyTerms(splitSize: splitSize)
    }
    
    func fetchStudyTerms(splitSize: Int) {
        let request: NSFetchRequest<Term> = Term.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Term.spelling, ascending: true)]
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
