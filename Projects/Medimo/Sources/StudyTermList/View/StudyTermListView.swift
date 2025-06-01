//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//
import SwiftUI
import CoreData

struct StudyTermListView: View {
    @Environment(\.managedObjectContext) private var context
    
    @State private var viewModel: StudyTermListViewModel
    
    init(glossary: Glossary, context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: StudyTermListViewModel(context: context, glossary: glossary, splitSize: 5))
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
    
    return StudyTermListView(glossary: glossary, context: context)
        .environment(\.managedObjectContext, context)
}
