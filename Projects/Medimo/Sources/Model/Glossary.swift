//
//  Glossary.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import Foundation
import CoreData

@objc(Glossary)
public class Glossary: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Glossary> {
        return NSFetchRequest<Glossary>(entityName: "Glossary")
    }

    @NSManaged public var id: UUID
    @NSManaged public var glossaryKey: String?
    @NSManaged public var title: String
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
