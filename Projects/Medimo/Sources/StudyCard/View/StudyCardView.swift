//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//
import SwiftUI
import CoreData

struct StudyCardView: View {
    @Environment(\.managedObjectContext) private var context
    
    @State private var viewModel: StudyCardViewModel
    
    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: StudyCardViewModel(glossary: glossary, studyTermSize: 5))
    }
    
    var body: some View {
        List(viewModel.studyTerms) { studyTerm in
            Text(studyTerm.spelling ?? "")
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    return StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
}
