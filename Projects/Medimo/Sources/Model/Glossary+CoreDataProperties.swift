//
//  Glossary+CoreDataProperties.swift
//  Medimo
//
//  Created by 양시준 on 6/1/25.
//
//

import Foundation
import CoreData


extension Glossary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Glossary> {
        return NSFetchRequest<Glossary>(entityName: "Glossary")
    }

    @NSManaged public var glossaryKey: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var terms: NSSet?

}

// MARK: Generated accessors for terms
extension Glossary {

    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)

}

extension Glossary {
    public var termsArray: [Term] {
        return Array(terms as! Set<Term>)
    }
}

extension Glossary : Identifiable {

}
