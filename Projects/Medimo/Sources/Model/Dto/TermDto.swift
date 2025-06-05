//
//  TermDto.swift
//  Projects
//
//  Created by 양시준 on 5/31/25.
//

import CloudKit

struct TermDto: Codable {
    let termKey: String
    let spelling: String
    let abbreviation: String?
    let meaning: String
    let explanation: String?
}

extension TermDto {
    static func recordToObj(record: CKRecord) -> TermDto {
        return TermDto(
            termKey: record["termKey"] as? String ?? "",
            spelling: record["spelling"] as? String ?? "",
            abbreviation: record["abbreviation"] as? String,
            meaning: record["meaning"] as? String ?? "",
            explanation: record["explanation"] as? String
        )
    }
}
