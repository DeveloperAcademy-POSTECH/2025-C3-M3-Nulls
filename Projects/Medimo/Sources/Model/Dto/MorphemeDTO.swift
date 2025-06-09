//
//  MorphemeDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct MorphemeDTO: Codable {
    let id: Int
    let spelling: String
    let meaning: String
//    let terms: [Int] // Term IDs
}

extension MorphemeDTO {
    static func recordToObj(record: CKRecord) -> MorphemeDTO {
        return MorphemeDTO(
            id: record["id"] as? Int ?? 0,
            spelling: record["spelling"] as? String ?? "",
            meaning: record["meaning"] as? String ?? ""
//            terms: record["terms"] as? [Int] ?? []
        )
    }
}
