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
    @State private var index: Int
    
    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: StudyCardViewModel(glossary: glossary, studyTermSize: 5))
        index = 1
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("\(index) / \(viewModel.studyTermSize)")
            
            CardView(term: viewModel.studyTerms[0])//index - 1])
                .padding(20)
            
            HStack(spacing: 6) {
                ForEach(0..<viewModel.studyTermSize, id: \.self) { i in
                    Circle()
                        .fill(i == index - 1 ? Color("Navy") : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }

            Spacer()

            if viewModel.studyTermSize == index {
                Button("문제 풀기") {
                    // TODO: 액션 정의
                }
                .frame(width: 220)
                .padding(20)
                .background(Color("Navy"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 3)
            }
        }
        .padding(20)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    return StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
}
