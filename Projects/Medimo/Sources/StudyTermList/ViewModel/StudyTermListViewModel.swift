//
//  StudyTermListViewModel.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import Foundation
import CoreData
import Observation

@Observable
class StudyTermListViewModel {
    var studyTerms: [Term] = []
    var glossary: Glossary
    var studyTermSize: Int
    
    init(glossary: Glossary, studyTermSize: Int) {
        self.glossary = glossary
        self.studyTermSize = studyTermSize
        self.studyTerms = getStudyTerms(glossary.termsArray, studyTermSize: studyTermSize)
    }

    func getStudyTerms(_ terms: [Term], studyTermSize: Int) -> [Term] {
        // TODO: getStudyTerms 고도화
        // 현재는 그냥 앞에서부터 studyTermSize 만큼 반환하도록 되어 있는데, 학습여부 등을 고려한 로직이 필요.
        // TODO: sutdyTermSize 설정
        // 하루에 몇 개씩 공부할 건 지 정할 수 있는 뷰가 생기면 그 쪽에서 데이터 받아와서 설정해야 함.
        var studyTerms: [Term] = []
        for i in stride(from: 0, to: terms.count, by: studyTermSize) {
            let endIndex = min(i + studyTermSize, terms.count)
            studyTerms.append(contentsOf: terms[i..<endIndex])
        }
        return studyTerms
    }
}
