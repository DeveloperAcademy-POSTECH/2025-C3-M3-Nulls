//
//  TermMorphemeRelationship+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension TermMorphemeRelationship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TermMorphemeRelationship> {
        return NSFetchRequest<TermMorphemeRelationship>(entityName: "TermMorphemeRelationship")
    }

    @NSManaged public var morphemeId: Int64
    @NSManaged public var order: Int16
    @NSManaged public var termId: Int64

}

extension TermMorphemeRelationship : Identifiable {

}
