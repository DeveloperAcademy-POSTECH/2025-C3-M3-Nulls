//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import SwiftUI
import CoreData

struct StudyTermListView: View {
    @Environment(\.managedObjectContext) var context
    @State var viewModel: StudyTermListViewModel
    
    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: StudyTermListViewModel(context: context))
    }
    
    var body: some View {
        List {
            ForEach(viewModel.studyTerms) { studyTerm in
                Text(studyTerm.spelling ?? "")
            }
        }
    }
}

#Preview {
    StudyTermListView(context: PersistenceController.preview.container.viewContext)
}
