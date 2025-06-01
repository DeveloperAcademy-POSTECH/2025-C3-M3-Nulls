//
//  Term+CoreDataProperties.swift
//  Medimo
//
//  Created by 양시준 on 6/1/25.
//
//

import Foundation
import CoreData


extension Term {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var abbreviation: String?
    @NSManaged public var explanation: String?
    @NSManaged public var id: UUID?
    @NSManaged public var meaning: String?
    @NSManaged public var spelling: String?
    @NSManaged public var termKey: String?
    @NSManaged public var glossarys: NSSet?
    @NSManaged public var morphemes: NSSet?

}

// MARK: Generated accessors for glossarys
extension Term {

    @objc(addGlossarysObject:)
    @NSManaged public func addToGlossarys(_ value: Glossary)

    @objc(removeGlossarysObject:)
    @NSManaged public func removeFromGlossarys(_ value: Glossary)

    @objc(addGlossarys:)
    @NSManaged public func addToGlossarys(_ values: NSSet)

    @objc(removeGlossarys:)
    @NSManaged public func removeFromGlossarys(_ values: NSSet)

}

// MARK: Generated accessors for morphemes
extension Term {

    @objc(addMorphemesObject:)
    @NSManaged public func addToMorphemes(_ value: Morpheme)

    @objc(removeMorphemesObject:)
    @NSManaged public func removeFromMorphemes(_ value: Morpheme)

    @objc(addMorphemes:)
    @NSManaged public func addToMorphemes(_ values: NSSet)

    @objc(removeMorphemes:)
    @NSManaged public func removeFromMorphemes(_ values: NSSet)

}

extension Term : Identifiable {

}
