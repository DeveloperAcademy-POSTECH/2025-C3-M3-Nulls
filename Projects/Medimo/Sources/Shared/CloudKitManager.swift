//
//  CloudKitManager.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//

import CloudKit
import Combine

enum CloudKitServiceError: Error, LocalizedError {
    case message(String)
    case unknown(Error)
    case custom(String)

    var errorDescription: String? {
        switch self {
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

    private let containerID = "iCloud.org.nulls.medimo.c3"
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
    // Read
    func fetchAllTerms() async -> Result<[TermDTO], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "Term", predicate: predicate)

        var allLoadedTerms: [TermDTO] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[TermDTO], CloudKitServiceError>, Never>
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
                    let term = TermDTO.recordToObj(record: record)
                    print("📝 fetched term: \(term)") // 디버깅용 출력
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
                    continuation.resume(returning: .failure(CloudKitServiceError.message(error.localizedDescription)))
                }
            }

            publicDatabase.add(operation)
        }

        return await withCheckedContinuation { continuation in
            fetchBatch(cursor: nil, continuation: continuation) // 초기 호출
        }
    }

    func fetchAllMorphemes() async -> Result<[MorphemeDTO], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "Morpheme", predicate: predicate)

        var allLoadedMorphemes: [MorphemeDTO] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[MorphemeDTO], CloudKitServiceError>, Never>
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
                    let morpheme = MorphemeDTO.recordToObj(record: record)
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

    func fetchAllTermMorphemeRelationships() async -> Result<[TermMorphemeRelationshipDTO], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "TermMorphemeRelationship", predicate: predicate)

        var allLoadedTermMorphemeRelationships: [TermMorphemeRelationshipDTO] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[TermMorphemeRelationshipDTO], CloudKitServiceError>, Never>
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
                    let relationship = TermMorphemeRelationshipDTO.recordToObj(record: record)
                    print("📝 fetched TermMorphemeRelationship: \(relationship)") // 디버깅용 출력
                    allLoadedTermMorphemeRelationships.append(relationship)
                }
            }

            operation.queryResultBlock = { result in
                switch result {
                case let .success(nextCursor):
                    if let nextCursor = nextCursor {
                        fetchBatch(cursor: nextCursor, continuation: continuation) // 다음 batch 재귀 호출
                    } else {
                        continuation.resume(returning: .success(allLoadedTermMorphemeRelationships)) // 마지막 batch에서만 호출
                    }

                case let .failure(error):
                    continuation.resume(returning: .failure(CloudKitServiceError.message(error.localizedDescription)))
                }
            }

            publicDatabase.add(operation)
        }

        return await withCheckedContinuation { continuation in
            fetchBatch(cursor: nil, continuation: continuation) // 초기 호출
        }
    }

    func fetchAllGlossaries() async -> Result<[GlossaryDTO], CloudKitServiceError> {
        let predicate = NSPredicate(value: true) // 모든 레코드 조회
        let query = CKQuery(recordType: "Glossary", predicate: predicate)

        var allLoadedGlossaries: [GlossaryDTO] = []

        func fetchBatch(
            cursor: CKQueryOperation.Cursor?,
            continuation: CheckedContinuation<Result<[GlossaryDTO], CloudKitServiceError>, Never>
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
                    let glossary = GlossaryDTO.recordToObj(record: record)
                    print("📝 fetched glossary: \(glossary)") // 디버깅용 출력
                    allLoadedGlossaries.append(glossary)
                }
            }

            operation.queryResultBlock = { result in
                switch result {
                case let .success(nextCursor):
                    if let nextCursor = nextCursor {
                        fetchBatch(cursor: nextCursor, continuation: continuation) // 다음 batch 재귀 호출
                    } else {
                        continuation.resume(returning: .success(allLoadedGlossaries)) // 마지막 batch에서만 호출
                    }

                case let .failure(error):
                    continuation.resume(returning: .failure(CloudKitServiceError.message(error.localizedDescription)))
                }
            }

            publicDatabase.add(operation)
        }

        return await withCheckedContinuation { continuation in
            fetchBatch(cursor: nil, continuation: continuation) // 초기 호출
        }
    }
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
