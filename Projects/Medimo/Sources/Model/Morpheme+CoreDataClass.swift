//
//  Morpheme+CoreDataClass.swift
//  Medimo
//
//  Created by 양시준 on 6/1/25.
//
//

import CoreData
import Foundation

@objc(Morpheme)
public class Morpheme: NSManagedObject {
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}
