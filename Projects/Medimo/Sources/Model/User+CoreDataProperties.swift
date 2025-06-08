//
//  User+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var currentStreak: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var longestStreak: Int64
    @NSManaged public var totalLearningTerms: Int64
    @NSManaged public var bookmarks: NSSet?
    @NSManaged public var progresses: NSSet?
    @NSManaged public var termStudyData: NSSet?
    @NSManaged public var totalStudyHist: NSSet?

}

// MARK: Generated accessors for bookmarks
extension User {

    @objc(addBookmarksObject:)
    @NSManaged public func addToBookmarks(_ value: Term)

    @objc(removeBookmarksObject:)
    @NSManaged public func removeFromBookmarks(_ value: Term)

    @objc(addBookmarks:)
    @NSManaged public func addToBookmarks(_ values: NSSet)

    @objc(removeBookmarks:)
    @NSManaged public func removeFromBookmarks(_ values: NSSet)

}

// MARK: Generated accessors for progresses
extension User {

    @objc(addProgressesObject:)
    @NSManaged public func addToProgresses(_ value: GlossaryProgress)

    @objc(removeProgressesObject:)
    @NSManaged public func removeFromProgresses(_ value: GlossaryProgress)

    @objc(addProgresses:)
    @NSManaged public func addToProgresses(_ values: NSSet)

    @objc(removeProgresses:)
    @NSManaged public func removeFromProgresses(_ values: NSSet)

}

// MARK: Generated accessors for termStudyData
extension User {

    @objc(addTermStudyDataObject:)
    @NSManaged public func addToTermStudyData(_ value: TermStudyData)

    @objc(removeTermStudyDataObject:)
    @NSManaged public func removeFromTermStudyData(_ value: TermStudyData)

    @objc(addTermStudyData:)
    @NSManaged public func addToTermStudyData(_ values: NSSet)

    @objc(removeTermStudyData:)
    @NSManaged public func removeFromTermStudyData(_ values: NSSet)

}

// MARK: Generated accessors for totalStudyHist
extension User {

    @objc(addTotalStudyHistObject:)
    @NSManaged public func addToTotalStudyHist(_ value: DateInfo)

    @objc(removeTotalStudyHistObject:)
    @NSManaged public func removeFromTotalStudyHist(_ value: DateInfo)

    @objc(addTotalStudyHist:)
    @NSManaged public func addToTotalStudyHist(_ values: NSSet)

    @objc(removeTotalStudyHist:)
    @NSManaged public func removeFromTotalStudyHist(_ values: NSSet)

}

extension User : Identifiable {

}
