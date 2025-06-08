//
//  TermMorphemeRelationshipDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct TermMorphemeRelationshipDTO: Codable {
    let termId: Int
    let morphemeId: Int
    let order: Int
}

extension TermMorphemeRelationshipDTO {
    static func recordToObj(record: CKRecord) -> TermMorphemeRelationshipDTO {
        return TermMorphemeRelationshipDTO(
            termId: record["termId"] as? Int ?? 0,
            morphemeId: record["morphemeId"] as? Int ?? 0,
            order: record["order"] as? Int ?? 0
        )
    }
}
