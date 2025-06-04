//
//  Term+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 6/1/25.
//
//

import CoreData
import Foundation

@objc(Term)
public class Term: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
