//
//  Glossary.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import Foundation
import CoreData

public class Glossary: NSManagedObject, Identifiable {
    
    public class func fetchRequest() -> NSFetchRequest<Glossary> {
        return NSFetchRequest<Glossary>(entityName: "Glossary")
    }

    @NSManaged public var id: UUID
    @NSManaged public var glossaryKey: String?
    @NSManaged public var title: String
    
    @NSManaged public var terms: Set<Term>

}
