//
//  Term+CoreDataProperties.swift
//  Medimo
//
//  Created by 이서현 on 6/2/25.
//
//

import CoreData
import Foundation
import SwiftUI

public extension Term {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged var abbreviation: String?
    @NSManaged var explanation: String?
    @NSManaged var id: UUID?
    @NSManaged var meaning: String?
    @NSManaged var spelling: String?
    @NSManaged var termKey: String?
    @NSManaged var isBookmarked: Bool
    @NSManaged var glossarys: NSSet?
    @NSManaged var morphemes: NSSet?
}

// MARK: Generated accessors for glossarys

public extension Term {
    @objc(addGlossarysObject:)
    @NSManaged func addToGlossarys(_ value: Glossary)

    @objc(removeGlossarysObject:)
    @NSManaged func removeFromGlossarys(_ value: Glossary)

    @objc(addGlossarys:)
    @NSManaged func addToGlossarys(_ values: NSSet)

    @objc(removeGlossarys:)
    @NSManaged func removeFromGlossarys(_ values: NSSet)
}

// MARK: Generated accessors for morphemes

public extension Term {
    @objc(addMorphemesObject:)
    @NSManaged func addToMorphemes(_ value: Morpheme)

    @objc(removeMorphemesObject:)
    @NSManaged func removeFromMorphemes(_ value: Morpheme)

    @objc(addMorphemes:)
    @NSManaged func addToMorphemes(_ values: NSSet)

    @objc(removeMorphemes:)
    @NSManaged func removeFromMorphemes(_ values: NSSet)
}

extension Term: Identifiable {}
