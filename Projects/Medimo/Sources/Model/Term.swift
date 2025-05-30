//
//  Term+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 5/30/25.
//
//

import Foundation
import CoreData

@objc(Term)
public class Term: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var id: UUID
    @NSManaged public var termKey: String?
    @NSManaged public var spelling: String
    @NSManaged public var abbreviation: String?
    @NSManaged public var meaning: String
    @NSManaged public var explanation: String?
    @NSManaged public var glossarys: NSSet?
    @NSManaged public var morphemes: NSSet?
    
    @objc(addGlossaryObject:)
    @NSManaged public func addToGlossarys(_ value: Glossary)

    @objc(removeGlossarysObject:)
    @NSManaged public func removeFromGlossarys(_ value: Glossary)

    @objc(addGlossarys:)
    @NSManaged public func addToGlossary(_ values: NSSet)

    @objc(removeGlossarys:)
    @NSManaged public func removeFromGlossarys(_ values: NSSet)
    
    @objc(addMorphemeObject:)
    @NSManaged public func addToMorphemes(_ value: Morpheme)
    
    @objc(removeMorphemesObject:)
    @NSManaged public func removeFromMorphemes(_ value: Morpheme)
    
    @objc(addMorphemes:)
    @NSManaged public func addToMorphemes(_ values: NSSet)
    
    @objc(removeMorphemes:)
    @NSManaged public func removeFromMorphemes(_ values: NSSet)
}
