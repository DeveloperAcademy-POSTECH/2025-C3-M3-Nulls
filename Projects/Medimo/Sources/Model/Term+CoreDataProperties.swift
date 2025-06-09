//
//  Term+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
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
    @NSManaged public var id: Int64
    @NSManaged public var meaning: String?
    @NSManaged public var spelling: String?
    @NSManaged public var bookmarks: NSSet?
    @NSManaged public var glossaries: NSSet?
    @NSManaged public var morphemes: NSSet?
    @NSManaged public var termStudyData: NSSet?

}

// MARK: Generated accessors for bookmarks
extension Term {

    @objc(addBookmarksObject:)
    @NSManaged public func addToBookmarks(_ value: User)

    @objc(removeBookmarksObject:)
    @NSManaged public func removeFromBookmarks(_ value: User)

    @objc(addBookmarks:)
    @NSManaged public func addToBookmarks(_ values: NSSet)

    @objc(removeBookmarks:)
    @NSManaged public func removeFromBookmarks(_ values: NSSet)

}

// MARK: Generated accessors for glossaries
extension Term {

    @objc(addGlossariesObject:)
    @NSManaged public func addToGlossaries(_ value: Glossary)

    @objc(removeGlossariesObject:)
    @NSManaged public func removeFromGlossaries(_ value: Glossary)

    @objc(addGlossaries:)
    @NSManaged public func addToGlossaries(_ values: NSSet)

    @objc(removeGlossaries:)
    @NSManaged public func removeFromGlossaries(_ values: NSSet)

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

// MARK: Generated accessors for termStudyData
extension Term {

    @objc(addTermStudyDataObject:)
    @NSManaged public func addToTermStudyData(_ value: TermStudyData)

    @objc(removeTermStudyDataObject:)
    @NSManaged public func removeFromTermStudyData(_ value: TermStudyData)

    @objc(addTermStudyData:)
    @NSManaged public func addToTermStudyData(_ values: NSSet)

    @objc(removeTermStudyData:)
    @NSManaged public func removeFromTermStudyData(_ values: NSSet)

}

extension Term : Identifiable {

}
