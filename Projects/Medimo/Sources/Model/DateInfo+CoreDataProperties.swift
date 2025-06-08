//
//  DateInfo+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension DateInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateInfo> {
        return NSFetchRequest<DateInfo>(entityName: "DateInfo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var reviewCount: Int32
    @NSManaged public var studyCount: Int32
    @NSManaged public var totalStudyHist: NSSet?

}

// MARK: Generated accessors for totalStudyHist
extension DateInfo {

    @objc(addTotalStudyHistObject:)
    @NSManaged public func addToTotalStudyHist(_ value: User)

    @objc(removeTotalStudyHistObject:)
    @NSManaged public func removeFromTotalStudyHist(_ value: User)

    @objc(addTotalStudyHist:)
    @NSManaged public func addToTotalStudyHist(_ values: NSSet)

    @objc(removeTotalStudyHist:)
    @NSManaged public func removeFromTotalStudyHist(_ values: NSSet)

}

extension DateInfo : Identifiable {

}
