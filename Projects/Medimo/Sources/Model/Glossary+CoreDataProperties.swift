//
//  Glossary+CoreDataProperties.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//
//

import Foundation
import CoreData


extension Glossary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Glossary> {
        return NSFetchRequest<Glossary>(entityName: "Glossary")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var progresses: NSSet?
    @NSManaged public var terms: NSSet?
    @NSManaged public var termStudyData: NSSet?

}

// MARK: Generated accessors for progresses
extension Glossary {

    @objc(addProgressesObject:)
    @NSManaged public func addToProgresses(_ value: GlossaryProgress)

    @objc(removeProgressesObject:)
    @NSManaged public func removeFromProgresses(_ value: GlossaryProgress)

    @objc(addProgresses:)
    @NSManaged public func addToProgresses(_ values: NSSet)

    @objc(removeProgresses:)
    @NSManaged public func removeFromProgresses(_ values: NSSet)

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

// MARK: Generated accessors for termStudyData
extension Glossary {

    @objc(addTermStudyDataObject:)
    @NSManaged public func addToTermStudyData(_ value: TermStudyData)

    @objc(removeTermStudyDataObject:)
    @NSManaged public func removeFromTermStudyData(_ value: TermStudyData)

    @objc(addTermStudyData:)
    @NSManaged public func addToTermStudyData(_ values: NSSet)

    @objc(removeTermStudyData:)
    @NSManaged public func removeFromTermStudyData(_ values: NSSet)

}

extension Glossary : Identifiable {

}
