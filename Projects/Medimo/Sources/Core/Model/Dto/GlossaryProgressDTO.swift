//
//  GlossaryProgress.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct GlossaryProgressDTO: Codable {
    let id: Int
    let lastStudiedAt: Date
    let studiedCount: Int
    let glossary: Int // Glossary ID
    let user: UUID // User ID
}

extension GlossaryProgressDTO {
    static func recordToObj(record: CKRecord) -> GlossaryProgressDTO {
        return GlossaryProgressDTO(
            id: record["id"] as? Int ?? 0,
            lastStudiedAt: record["lastStudiedAt"] as? Date ?? Date(),
            studiedCount: record["studiedCount"] as? Int ?? 0,
            glossary: record["glossary"] as? Int ?? 0,
            user: record["user"] as? UUID ?? UUID()
        )
    }
}
