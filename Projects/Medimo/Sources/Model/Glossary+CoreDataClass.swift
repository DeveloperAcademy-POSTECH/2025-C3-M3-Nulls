//
//  Glossary+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 6/1/25.
//
//

import CoreData
import Foundation

@objc(Glossary)
public class Glossary: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
