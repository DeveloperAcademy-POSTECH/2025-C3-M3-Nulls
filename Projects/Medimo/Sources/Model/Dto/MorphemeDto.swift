//
//  MorphemeDto.swift
//  Projects
//
//  Created by 양시준 on 5/31/25.
//

import CloudKit

struct MorphemeDto: Codable {
    let morphemeKey: String
    let spelling: String
    let meaning: String
}

extension MorphemeDto {
    static func recordToObj(record: CKRecord) -> MorphemeDto {
        return MorphemeDto(
            morphemeKey: record["morphemeKey"] as? String ?? "",
            spelling: record["spelling"] as? String ?? "",
            meaning: record["meaning"] as? String ?? ""
        )
    }
}
