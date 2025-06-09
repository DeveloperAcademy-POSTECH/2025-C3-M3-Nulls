//
//  TermStudyData.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import Foundation
import CloudKit

struct TermStudyDataDTO: Codable {
    let id: String
    let lastReviewedAt: Date
    let nextReviewAt: Date
    let reviewCount: Int
    let status: String
    let easeFactor: Double
    let user: String // User ID
    let term: Int // Term ID
    let glossary: Int// Glossary ID
}

extension TermStudyDataDTO {
    static func recordToObj(record: CKRecord) -> TermStudyDataDTO {
        return TermStudyDataDTO(
            id: record["id"] as? String ?? UUID().uuidString,
            lastReviewedAt: record["lastReviewedAt"] as? Date ?? Date(),
            nextReviewAt: record["nextReviewAt"] as? Date ?? Date(),
            reviewCount: record["reviewCount"] as? Int ?? 0,
            status: record["status"] as? String ?? "new",
            easeFactor: record["easeFactor"] as? Double ?? 2.5,
            user: record["user"] as? String ?? UUID().uuidString,
            term: record["term"] as? Int ?? 0,
            glossary: record["glossary"] as? Int ?? 0
        )
    }
}
