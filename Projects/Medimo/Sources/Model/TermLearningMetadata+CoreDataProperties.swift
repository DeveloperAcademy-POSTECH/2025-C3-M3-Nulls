//
//  TermLearningMetadata+CoreDataProperties.swift
//  Medimo
//
//  Created by 양시준 on 6/5/25.
//
//

import Foundation
import CoreData


extension TermLearningMetadata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermLearningMetadata> {
        return NSFetchRequest<TermLearningMetadata>(entityName: "TermLearningMetadata")
    }

    @NSManaged public var glossaryId: UUID?
    @NSManaged public var id: UUID?
    @NSManaged public var lastReviewedAt: Date?
    @NSManaged public var nextReviewAt: Date?
    @NSManaged public var status: String?
    @NSManaged public var termId: UUID?
    @NSManaged public var interval: Int32
    @NSManaged public var repetitions: Int32
    @NSManaged public var easeFactor: Double

}

extension TermLearningMetadata : Identifiable {

}
