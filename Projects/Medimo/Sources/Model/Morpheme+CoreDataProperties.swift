//
//  Morpheme+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension Morpheme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Morpheme> {
        return NSFetchRequest<Morpheme>(entityName: "Morpheme")
    }

    @NSManaged public var id: Int64
    @NSManaged public var meaning: String?
    @NSManaged public var spelling: String?
    @NSManaged public var terms: NSSet?

}

// MARK: Generated accessors for terms
extension Morpheme {

    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)

}

extension Morpheme : Identifiable {

}
