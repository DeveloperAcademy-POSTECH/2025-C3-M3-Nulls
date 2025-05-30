//
//  Morpheme+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 5/30/25.
//
//

import Foundation
import CoreData

public class Morpheme: NSManagedObject, Identifiable {
    
    public class func fetchRequest() -> NSFetchRequest<Morpheme> {
        return NSFetchRequest<Morpheme>(entityName: "Morpheme")
    }

    @NSManaged public var id: UUID
    @NSManaged public var morphemeKey: String?
    @NSManaged public var spelling: String
    @NSManaged public var meaning: String
    
    @NSManaged public var terms: Set<Term>
    
}
