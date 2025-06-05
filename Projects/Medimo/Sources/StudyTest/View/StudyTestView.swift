//
//  StudyTestView.swift
//  Projects
//
//  Created by 이서현 on 6/3/25.
//

import SwiftUI

struct StudyTestView: View {
    var terms: [Term]
    var body: some View {
        List(terms, id: \.self) { term in
            Text(term.spelling ?? "")
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext

    // 테스트용 임시 Term 생성
    let fallbackTerm = Term(context: context)
    fallbackTerm.id = UUID()
    fallbackTerm.spelling = "Fallback"
    fallbackTerm.meaning = "임시 값"

    // StudyManager가 세팅돼 있고 Term을 가져올 수 있는지 확인
    StudyManager.shared.setContext(context)
    let terms = StudyManager.shared.getNextStudyTerms()

    return StudyTestView(terms: terms.isEmpty ? [fallbackTerm] : terms)
        .environment(\.managedObjectContext, context)
}
