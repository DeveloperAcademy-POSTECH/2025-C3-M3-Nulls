//
//  TermDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct TermDTO: Codable {
    let id: Int
    let spelling: String
    let meaning: String
    let explanation: String
    let abbreviation: String
//    let bookmarks: [String] // User IDs
//    let glossaries: [Int] // Glossary IDs
//    let morphemes: [Int] // Morpheme IDs
//    let termStudyData: [Int] // TermStudyData IDs
}

extension TermDTO {
    static func recordToObj(record: CKRecord) -> TermDTO {
        return TermDTO(
            id: record["id"] as? Int ?? 0,
            spelling: record["spelling"] as? String ?? "",
            meaning: record["meaning"] as? String ?? "",
            explanation: record["explanation"] as? String ?? "",
            abbreviation: record["abbreviation"] as? String ?? ""
//            bookmarks: [],
//            glossaries: record["glossaries"] as? [Int] ?? [],
//            morphemes: record["morphemes"] as? [Int] ?? [],
//            termStudyData: []
        )
    }
}
