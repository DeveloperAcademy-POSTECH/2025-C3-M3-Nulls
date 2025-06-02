//
//  TermLearningStatus+CoreDataProperties.swift
//  Medimo
//
//  Created by 양시준 on 6/2/25.
//
//

import Foundation
import CoreData


extension TermLearningStatus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermLearningStatus> {
        return NSFetchRequest<TermLearningStatus>(entityName: "TermLearningStatus")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var status: String?
    @NSManaged public var lastReviewedAt: Date?
    @NSManaged public var nextReviewAt: Date?
    @NSManaged public var glossaryId: UUID?
    @NSManaged public var termId: UUID?

}

extension TermLearningStatus : Identifiable {

}
