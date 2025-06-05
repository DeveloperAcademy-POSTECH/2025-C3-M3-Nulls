//
//  CloudKitManager.swift
//  Projects
//
//  Created by 김현기 on 6/4/25.
//

import CloudKit
import Combine

enum CloudKitServiceError: Error, LocalizedError {
    case recordNotFound
    case permissionDenied
    case networkUnavailable
    case message(String)
    case unknown(Error)
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .recordNotFound:
            return "The requested record was not found."
        case .permissionDenied:
            return "Permission denied for this operation."
        case .networkUnavailable:
            return "Network is unavailable. Please check your connection."
        case let .message(message):
            return message
        case let .unknown(error):
            return error.localizedDescription
        case let .custom(message):
            return message
        }
    }
}

class CloudKitManager {
    static let shared = CloudKitManager()

    private let containerID = "iCloud.org.nulls.Medimo"
    private let zone = CKRecordZone.default()
    private var container: CKContainer {
        CKContainer(identifier: containerID)
    }

    private var publicDatabase: CKDatabase {
        container.publicCloudDatabase
    }

    // 아이클라우드 원격 데이터로부터 마지막 체인지 토큰
    var lastChangeToken: CKServerChangeToken?
}

// MARK: - CRUD Operations

extension CloudKitManager {
    // Save
    //    func saveBookmark() {
    //        isLoading = true
    //
    //
    //        publicDatabase.save(record) { [weak self] _, error in
    //            DispatchQueue.main.async {
    //                self?.isLoading = false
    //                if let error {
    //                    self?.error = error.localizedDescription
    //                } else {
    //                    self?.fetchGlossaries() // 생성 후 목록 갱신
    //                }
    //            }
    //        }
    //    }

    // Read
    func fetchAllMorphemes() async -> Result<[MorphemeDto], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "Morphemes", predicate: predicate)

        var allLoadedMorphemes: [MorphemeDto] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[MorphemeDto], CloudKitServiceError>, Never>
        ) {
            let operation: CKQueryOperation
            if let cursor = cursor {
                operation = CKQueryOperation(cursor: cursor)
            } else {
                operation = CKQueryOperation(query: query)
            }
            operation.database = publicDatabase

            operation.recordMatchedBlock = { _, result in
                if case let .success(record) = result {
                    let morpheme = MorphemeDto.recordToObj(record: record)
                    allLoadedMorphemes.append(morpheme)
                }
            }

            operation.queryResultBlock = { result in
                switch result {
                case let .success(nextCursor):
                    if let nextCursor = nextCursor {
                        fetchBatch(cursor: nextCursor, continuation: continuation) // 다음 batch 재귀 호출
                    } else {
                        continuation.resume(returning: .success(allLoadedMorphemes)) // 마지막 batch에서만 호출
                    }

                case let .failure(error):
                    continuation.resume(returning: .failure(.message(error.localizedDescription)))
                }
            }

            publicDatabase.add(operation)
        }
        
        return await withCheckedContinuation { continuation in
            fetchBatch(cursor: nil, continuation: continuation) // 초기 호출
        }
    }

    func fetchAllTerms() async -> Result<[TermDto], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "Terms", predicate: predicate)

        var allLoadedTerms: [TermDto] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[TermDto], CloudKitServiceError>, Never>
        ) {
            let operation: CKQueryOperation
            if let cursor = cursor {
                operation = CKQueryOperation(cursor: cursor)
            } else {
                operation = CKQueryOperation(query: query)
            }
            operation.database = publicDatabase

            operation.recordMatchedBlock = { _, result in
                if case let .success(record) = result {
                    let term = TermDto.recordToObj(record: record)
                    allLoadedTerms.append(term)
                }
            }

            operation.queryResultBlock = { result in
                switch result {
                case let .success(nextCursor):
                    if let nextCursor = nextCursor {
                        fetchBatch(cursor: nextCursor, continuation: continuation) // 다음 batch 재귀 호출
                    } else {
                        continuation.resume(returning: .success(allLoadedTerms)) // 마지막 batch에서만 호출
                    }

                case let .failure(error):
                    continuation.resume(returning: .failure(.message(error.localizedDescription)))
                }
            }

            publicDatabase.add(operation)
        }

        return await withCheckedContinuation { continuation in
            fetchBatch(cursor: nil, continuation: continuation) // 초기 호출
        }
    }

//            publicDatabase.fetch(
//                withQuery: query,
//                inZoneWith: zone.zoneID,
//                desiredKeys: nil,
//                resultsLimit: CKQueryOperation.maximumResults
//            ) { result in
//                switch result {
//                case let .success(success):
//                    let records = success.matchResults.compactMap { try? $0.1.get() }
//                    var terms: [TermDto] = []
//
//                    for record in records {
//                        let term = TermDto.recordToObj(record: record)
//                        terms.append(term)
//                    }
//
//                    continuation.resume(returning: .success(terms))
//
//                case let .failure(failure):
//                    continuation.resume(returning: .failure(.message(failure.localizedDescription)))
//                }
//            }
//        }
//    }

    // Update
//    func updateGlossary(_ dto: GlossaryDto) {
//        isLoading = true
//        let recordID = CKRecord.ID(recordName: dto.glossaryKey)
//
//        publicDatabase.fetch(withRecordID: recordID) { [weak self] record, error in
//            guard let record else {
//                DispatchQueue.main.async {
//                    self?.error = error?.localizedDescription ?? "Unknown error"
//                }
//                return
//            }
//
//            record["title"] = dto.title
//            self?.publicDatabase.save(record) { _, error in
//                DispatchQueue.main.async {
//                    self?.isLoading = false
//                    if let error {
//                        self?.error = error.localizedDescription
//                    } else {
//                        self?.fetchGlossaries()
//                    }
//                }
//            }
//        }
//    }

    // Delete
//    func deleteGlossary(_ dto: GlossaryDto) {
//        isLoading = true
//        let recordID = CKRecord.ID(recordName: dto.glossaryKey)
//
//        publicDatabase.delete(withRecordID: recordID) { [weak self] _, error in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                if let error {
//                    self?.error = error.localizedDescription
//                } else {
//                    self?.glossaries.removeAll { $0.id == dto.id }
//                }
//            }
//        }
//    }
}

// MARK: - Sub Operations

extension CloudKitManager {
    func checkiCloudAccountStatus(completion: @escaping (CKAccountStatus) -> Void) {
        container.accountStatus { accountStatus, error in
            if let error = error {
                print("Error fetching iCloud account status: \(error)")
                return
            }

            switch accountStatus {
            case .available:
                completion(.available)

            case .noAccount:
                print("No iCloud account found. Please log in to iCloud.")

            case .restricted:
                print("iCloud account is restricted.")

            case .couldNotDetermine:
                print("Could not determine iCloud account status.")

            case .temporarilyUnavailable:
                print("iCloud account status is temporarily unavailable.")

            @unknown default:
                print("Unknown iCloud account status.")
            }
        }
    }
}
