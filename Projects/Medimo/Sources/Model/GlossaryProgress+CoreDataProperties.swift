//
//  GlossaryProgress+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension GlossaryProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GlossaryProgress> {
        return NSFetchRequest<GlossaryProgress>(entityName: "GlossaryProgress")
    }

    @NSManaged public var id: Int64
    @NSManaged public var lastStudiedAt: Date?
    @NSManaged public var studiedCount: Int64
    @NSManaged public var glossary: Glossary?
    @NSManaged public var user: User?

}

extension GlossaryProgress : Identifiable {

}
