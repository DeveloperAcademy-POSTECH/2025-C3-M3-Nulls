//
//  Term+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 5/30/25.
//
//

import Foundation
import CoreData

public class Term: NSManagedObject, Identifiable {
    
    public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var id: UUID
    @NSManaged public var termKey: String?
    @NSManaged public var spelling: String
    @NSManaged public var abbreviation: String?
    @NSManaged public var meaning: String
    @NSManaged public var explanation: String?
    
    @NSManaged public var glossarys: Set<Glossary>
    @NSManaged public var morphemes: Set<Morpheme>
    
}
