//
//  DateInfoDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct DateInfoDTO: Codable {
    let date: Date
    let reviewCount: Int
    let studyCount: Int
    let totalStudyHist: [String] // User IDs
}

extension DateInfoDTO {
    static func recordToObj(record: CKRecord) -> DateInfoDTO {
        return DateInfoDTO(
            date: record["date"] as? Date ?? Date(),
            reviewCount: record["reviewCount"] as? Int ?? 0,
            studyCount: record["studyCount"] as? Int ?? 0,
            totalStudyHist: record["totalStudyHist"] as? [String] ?? []
        )
    }
}
