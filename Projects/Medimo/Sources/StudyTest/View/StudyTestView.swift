//
//  StudyTestView.swift
//  Projects
//
//  Created by 이서현 on 6/3/25.
//

import SwiftUI

struct StudyTestView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) private var context
    
    private var viewModel: StudyTestViewModel
    @State private var index: Int = 1
    
    var terms: [Term]
    var studyTermSize: Int {
        terms.count
    }
    
    init(terms: [Term], viewModel: StudyTestViewModel = StudyTestViewModel()) {
        self.terms = terms
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ProgressBar(index: index, total: terms.count)
            List(terms, id: \.self) { term in
                Text(term.spelling ?? "")
            }
        }
        .padding(32)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext

    let fallbackTerm = Term(context: context)
    fallbackTerm.id = UUID()
    fallbackTerm.spelling = "Fallback"
    fallbackTerm.meaning = "임시 값"

    StudyManager.shared.setContext(context)
    let terms = StudyManager.shared.getNextStudyTerms()

    return StudyTestView(terms: terms.isEmpty ? [fallbackTerm] : terms)
        .environment(\.managedObjectContext, context)
}
