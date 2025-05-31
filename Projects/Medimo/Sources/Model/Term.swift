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
    @NSManaged public var glossaries: NSSet?
    @NSManaged public var morphemes: NSSet?
    
    @objc(addGlossariesObject:)
    @NSManaged public func addToGlossaries(_ value: Glossary)

    @objc(removeGlossariesObject:)
    @NSManaged public func removeFromGlossaries(_ value: Glossary)

    @objc(addGlossaries:)
    @NSManaged public func addToGlossaries(_ values: NSSet)

    @objc(removeGlossaries:)
    @NSManaged public func removeFromGlossaries(_ values: NSSet)
    
    @objc(addMorphemeObject:)
    @NSManaged public func addToMorphemes(_ value: Morpheme)
    
    @objc(removeMorphemesObject:)
    @NSManaged public func removeFromMorphemes(_ value: Morpheme)
    
    @objc(addMorphemes:)
    @NSManaged public func addToMorphemes(_ values: NSSet)
    
    @objc(removeMorphemes:)
    @NSManaged public func removeFromMorphemes(_ values: NSSet)
}
