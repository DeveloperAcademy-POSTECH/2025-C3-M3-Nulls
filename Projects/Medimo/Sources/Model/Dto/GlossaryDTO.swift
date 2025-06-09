//
//  GlossaryDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct GlossaryDTO: Codable {
    let id: Int
    let title: String
    let category: String
//    let progresses: [String] // GlossaryProgress IDs
    let terms: [Int] // Term IDs
//    let termStudyData: [Int] // TermStudyData IDs
}

extension GlossaryDTO {
    static func recordToObj(record: CKRecord) -> GlossaryDTO {
        return GlossaryDTO(
            id: record["id"] as? Int ?? 0,
            title: record["title"] as? String ?? "",
            category: record["category"] as? String ?? "",
//            progresses: [],
            terms: record["terms"] as? [Int] ?? []
//            termStudyData: []
        )
    }
}
