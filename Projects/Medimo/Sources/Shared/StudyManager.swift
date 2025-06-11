//
//  StudyManager.swift
//  Projects
//
//  Created by 양시준 on 6/2/25.
//

import CoreData
import Foundation

@Observable
public class StudyManager {
    static let shared = StudyManager()

    private init() {}

    private var context: NSManagedObjectContext?

    let coredataManager = CoreDataManager.shared

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? coredataManager.context.fetch(fetchRequest)) ?? []

        return users.first ?? User(context: coredataManager.context)
    }

    var studyTermSize: Int = StudyTermSizeOption.small.rawValue

    private var _cachedStudyingGlossary: Glossary?
    private var _cachedTermStudyDataList: [TermStudyData]?

    var studyingGlossaryId: Int64? {
        didSet {
            _cachedStudyingGlossary = nil
            _cachedTermStudyDataList = nil
        }
    }

    func setContext(_ context: NSManagedObjectContext) {
        if self.context === context { return }
        
        self.context = context

        let request: NSFetchRequest<Glossary> = Glossary.fetchRequest()
        request.fetchLimit = 1

        do {
            if let glossary = try context.fetch(request).first {
                studyingGlossaryId = glossary.id
            } else {
                studyingGlossaryId = nil
            }
        } catch {
            print("❌ Glossary fetch 실패: \(error)")
            studyingGlossaryId = nil
        }
    }

    var studyingGlossary: Glossary? {
        if let cached = _cachedStudyingGlossary {
            return cached
        }
        guard let id = studyingGlossaryId else { return nil }

        let request: NSFetchRequest<Glossary> = Glossary.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1

        do {
            let result = try context?.fetch(request).first
            _cachedStudyingGlossary = result
            return result
        } catch {
            print("Glossary fetch 실패: \(error)")
            _cachedStudyingGlossary = nil
            return nil
        }
    }

    var currentGlossaryProgress: GlossaryProgress? {
        let currentProgress: GlossaryProgress? = (user.progresses as? Set<GlossaryProgress>)?
            .first(where: { $0.glossary?.id == studyingGlossaryId })
        return currentProgress
    }

    var termStudyDataList: [TermStudyData]? {
        if let cached = _cachedTermStudyDataList {
            return cached
        }

        guard let id = studyingGlossaryId as Int64? else { return nil }

        let request: NSFetchRequest<TermStudyData> = TermStudyData.fetchRequest()
        request.predicate = NSPredicate(format: "glossary.id == %d", id)

        do {
            let result = try context?.fetch(request)
            _cachedTermStudyDataList = result
            return result
        } catch {
            print("TermStudyData fetch 실패: \(error)")
            _cachedTermStudyDataList = nil
            return nil
        }
    }

    func getNextStudyTerms() -> [Term] {
        guard let dataList = termStudyDataList else { return [] }

        var termIdList: [Int64] = []

        let inProgressTermIdList = dataList
            .filter { $0.status == LearningStatus.inProgress.rawValue }
            .sorted { ($0.term?.id ?? 0) < ($1.term?.id ?? 0) }
            .compactMap { $0.term?.id }
        termIdList.append(contentsOf: inProgressTermIdList.prefix(studyTermSize))

        if termIdList.count < studyTermSize {
            let notStartedTermIdList = dataList
                .filter { $0.status == LearningStatus.notStarted.rawValue }
                .sorted { ($0.term?.id ?? 0) < ($1.term?.id ?? 0) }
                .compactMap { $0.term?.id }
            termIdList.append(contentsOf: notStartedTermIdList.prefix(studyTermSize - termIdList.count))
        }

        var result: [Term] = []

        for termId in termIdList {
            if let data = dataList.first(where: { $0.term?.id == termId }),
               let term = data.term
            {
                data.status = LearningStatus.inProgress.rawValue
                result.append(term)
                if result.count >= studyTermSize { break }
            }
        }
        return result
    }

    func updateReview(of term: Term, result: QuizResult) {
        let now = Date()

        let meta = termStudyDataList!.first(where: { $0.term?.id == term.id })!

        meta.status = LearningStatus.completed.rawValue

        switch result {
        case .correct:
            meta.reviewCount += 1
            if meta.reviewCount == 1 {
                meta.interval = 1
            } else if meta.reviewCount == 2 {
                meta.interval = 3
            } else {
                // SM-2: I(n) = I(n-1) * EF
                meta.interval = Int64(Int(Double(meta.interval) * meta.easeFactor))
            }
            meta.easeFactor = max(1.3, meta.easeFactor)

        case .incorrect:
            meta.interval = 1
            meta.reviewCount = 0
            meta.easeFactor = max(1.3, meta.easeFactor - 0.2)
        }

        meta.lastReviewedAt = now
        meta.nextReviewAt = Calendar.current.date(byAdding: .day, value: Int(meta.interval), to: now)!
        #if DEBUG
            meta.nextReviewAt = now
        #endif

        do {
            try context?.save()
            print("✅ 학습 결과 저장 완료: \(result) for \(term.spelling ?? "")")
        } catch {
            print("❌ 학습 결과 저장 실패: \(error.localizedDescription)")
        }
    }

    func getTodayReviewTerms() -> [Term] {
        guard studyingGlossaryId != nil else { return [] }
        guard termStudyDataList != nil else { return [] }

        var termIdList: [Int64] = []

        let today = Date()

        let todayReviewTermIdList = termStudyDataList!
            .filter { $0.nextReviewAt != nil && $0.nextReviewAt! <= today }
            .sorted { $0.nextReviewAt! < $1.nextReviewAt! }
            .prefix(studyTermSize)
            .map { $0.term!.id }
        termIdList.append(contentsOf: todayReviewTermIdList)

        var result: [Term] = []
        for termId in termIdList {
            guard
                let termsSet = studyingGlossary?.terms as? Set<Term>,
                let term = termsSet.first(where: { $0.id == termId })
            else { continue }
            result.append(term)
        }

        return result
    }

    // MARK: - CoreData Management

    func isTodayDateInfoExists() -> (exists: Bool, dateInfo: DateInfo?) {
        let fetchRequest: NSFetchRequest<DateInfo> = DateInfo.fetchRequest()
        do {
            let results = try coredataManager.context.fetch(fetchRequest)
            let today = Date()
            if let dateInfo = results.first(where: { $0.date != nil && Calendar.current.isDate($0.date!, inSameDayAs: today) }) {
                return (true, dateInfo)
            } else {
                return (false, nil)
            }
        } catch {
            print("❌ DateInfo fetch 실패: \(error)")
            return (false, nil)
        }
    }

    func addDateInfoWhenFinished() {
        let (exists, dateInfo) = isTodayDateInfoExists()

        if exists {
            print("📅 오늘 날짜 정보가 이미 존재합니다.")

            dateInfo!.studyCount += Int32(studyTermSize)
            dateInfo!.reviewCount += Int32(studyTermSize) // 임시
            print("📅 오늘 날짜 정보 업데이트: studyCount = \(dateInfo!.studyCount), reviewCount = \(dateInfo!.reviewCount)")
        } else {
            print("📅 오늘 날짜 정보가 존재하지 않습니다. 추가합니다.")

            let dateInfo = DateInfo(context: coredataManager.context)
            dateInfo.date = Date()
            dateInfo.studyCount = Int32(studyTermSize)
            dateInfo.reviewCount = Int32(studyTermSize) // 임시

            user.addToDateInfos(dateInfo)
        }
        coredataManager.save()
    }

    func checkCurrentGlossaryProgress() {
        let currentProgress: GlossaryProgress? = (user.progresses as? Set<GlossaryProgress>)?
            .first(where: { $0.glossary?.id == studyingGlossaryId })

        let progressList = user.progresses as? Set<GlossaryProgress> ?? []

        print("✏️ 현재 유저: \(String(describing: progressList))")
        print("✏️ 현재 Glossary: \(String(describing: studyingGlossary?.title))")
        print("✏️ 현재 학습 진행 상황: \(String(describing: currentProgress))")
    }

    func updateGlossaryProgress() {
        let currentProgress: GlossaryProgress? = (user.progresses as? Set<GlossaryProgress>)?
            .first(where: { $0.glossary?.id == studyingGlossaryId })

        print("✏️ 입력전 Progress 학습 진행 상황: \(String(describing: currentProgress))")

        currentProgress?.lastStudiedAt = Date()
        currentProgress?.studiedCount += Int64(studyTermSize)

//        if currentProgress != nil {
//            user.addToProgresses(currentProgress!)
//        }

        coredataManager.save()
    }
}
