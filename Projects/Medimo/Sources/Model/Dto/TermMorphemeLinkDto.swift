//
//  TermMorphemeLinkDto.swift
//  Projects
//
//  Created by 양시준 on 5/31/25.
//

import CloudKit

struct TermMorphemeLinkDto: Codable {
    let termKey: String
    let morphemeKey: String
    let order: Int
}

extension TermMorphemeLinkDto {
    static func recordToObj(record: CKRecord) -> TermMorphemeLinkDto {
        return TermMorphemeLinkDto(
            termKey: record["termKey"] as? String ?? "",
            morphemeKey: record["morphemeKey"] as? String ?? "",
            order: record["order"] as? Int ?? 1
        )
    }
}
