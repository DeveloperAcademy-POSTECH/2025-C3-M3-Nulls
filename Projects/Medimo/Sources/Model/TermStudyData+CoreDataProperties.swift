//
//  TermStudyData+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension TermStudyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermStudyData> {
        return NSFetchRequest<TermStudyData>(entityName: "TermStudyData")
    }

    @NSManaged public var interval: Int64
    @NSManaged public var easeFactor: Double
    @NSManaged public var id: UUID?
    @NSManaged public var lastReviewedAt: Date?
    @NSManaged public var nextReviewAt: Date?
    @NSManaged public var reviewCount: Int32
    @NSManaged public var status: String?
    @NSManaged public var glossary: Glossary?
    @NSManaged public var term: Term?
    @NSManaged public var user: User?

}

extension TermStudyData : Identifiable {

}
