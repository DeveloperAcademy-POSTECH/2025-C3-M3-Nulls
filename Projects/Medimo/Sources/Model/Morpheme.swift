//
//  Morpheme+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 5/30/25.
//
//

import Foundation
import CoreData

@objc(Morpheme)
public class Morpheme: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Morpheme> {
        return NSFetchRequest<Morpheme>(entityName: "Morpheme")
    }

    @NSManaged public var id: UUID
    @NSManaged public var morphemeKey: String?
    @NSManaged public var spelling: String
    @NSManaged public var meaning: String
    @NSManaged public var terms: NSSet?
    
    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)
}
