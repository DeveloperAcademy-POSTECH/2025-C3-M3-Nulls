//
//  CloudKitManager.swift
//  Projects
//
//  Created by 김현기 on 6/4/25.
//

import CloudKit
import Combine

final class CloudKitManager: ObservableObject {
    private let publicDB = CKContainer.default().publicCloudDatabase

    // MARK: - Published Properties

    @Published var glossaries: [GlossaryDto] = []
    @Published var isLoading = false
    @Published var error: String?

    // MARK: - Data Model

    struct GlossaryDto: Codable, Identifiable {
        var id: String { glossaryKey }
        let glossaryKey: String
        let title: String

        init(record: CKRecord) {
            glossaryKey = record.recordID.recordName
            title = record["title"] as? String ?? "No Title"
        }

        func toCKRecord() -> CKRecord {
            let recordID = CKRecord.ID(recordName: glossaryKey)
            let record = CKRecord(recordType: "Glossary", recordID: recordID)
            record["title"] = title
            return record
        }
    }
}

// MARK: - CRUD Operations

extension CloudKitManager {
    // Create
    func createGlossary(_ dto: GlossaryDto) {
        isLoading = true
        let record = dto.toCKRecord()

        publicDB.save(record) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error {
                    self?.error = error.localizedDescription
                } else {
                    self?.fetchGlossaries() // 생성 후 목록 갱신
                }
            }
        }
    }

    // Read
    func fetchGlossaries() {
        isLoading = true
        let query = CKQuery(
            recordType: "Glossary",
            predicate: NSPredicate(value: true)
        )

        publicDB.perform(query, inZoneWith: nil) { [weak self] records, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let records {
                    self?.glossaries = records.map(GlossaryDto.init)
                } else if let error {
                    self?.error = error.localizedDescription
                }
            }
        }
    }

    // Update
    func updateGlossary(_ dto: GlossaryDto) {
        isLoading = true
        let recordID = CKRecord.ID(recordName: dto.glossaryKey)

        publicDB.fetch(withRecordID: recordID) { [weak self] record, error in
            guard let record else {
                DispatchQueue.main.async {
                    self?.error = error?.localizedDescription ?? "Unknown error"
                }
                return
            }

            record["title"] = dto.title
            self?.publicDB.save(record) { _, error in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let error {
                        self?.error = error.localizedDescription
                    } else {
                        self?.fetchGlossaries()
                    }
                }
            }
        }
    }

    // Delete
    func deleteGlossary(_ dto: GlossaryDto) {
        isLoading = true
        let recordID = CKRecord.ID(recordName: dto.glossaryKey)

        publicDB.delete(withRecordID: recordID) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error {
                    self?.error = error.localizedDescription
                } else {
                    self?.glossaries.removeAll { $0.id == dto.id }
                }
            }
        }
    }
}
