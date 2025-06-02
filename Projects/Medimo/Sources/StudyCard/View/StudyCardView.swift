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
    
    @Bindable private var viewModel: StudyCardViewModel
    @State private var index: Int
    
    init(glossary: Glossary) {
        _viewModel = .init(wrappedValue: StudyCardViewModel(glossary: glossary, studyTermSize: 5))
        index = 5
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ProgressView(value: Double(index) / Double(viewModel.studyTermSize))
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                .padding(.trailing)
                    
                    Text("\(String(format: "%02d", index)) / \(viewModel.studyTermSize)")
                }
                .padding(.bottom)
                
                TermCardView(term: viewModel.studyTerms[index - 1])
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let horizontalAmount = value.translation.width
                                
                                if horizontalAmount < -50, index < viewModel.studyTermSize {
                                    index += 1
                                } else if horizontalAmount > 50, index > 1 {
                                    index -= 1
                                }
                            }
                    )
                
                Spacer()
                
                Button("문제 풀기") {
                    // TODO: 액션 정의
                }
                .frame(width: 220)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(Color("Navy"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 3)
                .opacity(viewModel.studyTermSize == index ? 1 : 0)
                
                Spacer()
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
}
