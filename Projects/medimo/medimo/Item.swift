//
//  Item.swift
//  medimo
//
//  Created by 양시준 on 5/28/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
