//
//  UserDTO.swift
//  CloudKit-CoreData
//
//  Created by 김현기 on 6/8/25.
//

import CloudKit
import Foundation

struct UserDTO: Codable {
    let id: String
    let currentStreak: Int
    let longestStreak: Int
    let totalLearningTerms: Int
    let bookmarks: [Int] // Term IDs
    let progresses: [String] // Progress IDs
    let termStudyData: [String] // TermStudyData IDs
    let totalStudyHist: [Date]
}

extension UserDTO {
    static func recordToObj(record: CKRecord) -> UserDTO {
        return UserDTO(
            id: record["id"] as? String ?? UUID().uuidString,
            currentStreak: record["currentStreak"] as? Int ?? 0,
            longestStreak: record["longestStreak"] as? Int ?? 0,
            totalLearningTerms: record["totalLearningTerms"] as? Int ?? 0,
            bookmarks: record["bookmarks"] as? [Int] ?? [],
            progresses: record["progresses"] as? [String] ?? [],
            termStudyData: record["termStudyData"] as? [String] ?? [],
            totalStudyHist: (record["totalStudyHist"] as? [Date] ?? []).sorted(by: { $0 < $1 })
        )
    }
}
