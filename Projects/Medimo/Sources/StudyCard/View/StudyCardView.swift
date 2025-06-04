//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//
import CoreData
import SwiftUI

struct StudyCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) private var context
    
    @Bindable private var viewModel: StudyCardViewModel
    @State private var index: Int = 1
    
    var terms: [Term] {
        viewModel.getStudyTerms()
    }
    var studyTermSize: Int {
        terms.count
    }
    
    init(glossary: Glossary) {
        _viewModel = .init(wrappedValue: StudyCardViewModel())
    }
    
    var body: some View {
        //        NavigationStack(path: $navigationManager.path) {
        VStack {
            HStack {
                if studyTermSize > 0 {
                    ProgressView(value: Double(index), total: Double(studyTermSize))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.trailing)
                    
                    Text("\(String(format: "%02d", index)) / \(studyTermSize)")
                        .font(.MM_AT)
                        .foregroundColor(Color("MM_Navy"))
                } else {
                    Text("학습할 용어가 없습니다.")
                        .font(.MM_AT)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)
            if terms.indices.contains(index - 1) {
                TermCardView(term: terms[index - 1])
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let horizontalAmount = value.translation.width
                                
                                if horizontalAmount < -50, index < studyTermSize {
                                    index += 1
                                } else if horizontalAmount > 50, index > 1 {
                                    index -= 1
                                }
                            }
                    )
            }
            
            Spacer()
            
            Button("용어 테스트 시작") {
                navigationManager.push(to: .StudyTest(terms: terms))
            }
            .font(.MM_Pr)
            .frame(width: 262, height: 40)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(Color("MM_Navy"))
            .foregroundColor(Color("MM_White"))
            .cornerRadius(16)
            .shadow(radius: 3)
            .opacity(studyTermSize == index ? 1 : 0)
            
            Spacer()
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 20)
        .onAppear {
            StudyManager.shared.setContext(context)
        }
    }
}
#Preview {
    let context = PersistenceController.preview.container.viewContext

    let glossary = Glossary(context: context)
    glossary.id = UUID()
    glossary.title = "프리뷰 용어집"

    let term = Term(context: context)
    term.id = UUID()
    term.spelling = "Preview"
    term.meaning = "미리보기"
    glossary.addToTerms(term)

    try? context.save()
    
    StudyManager.shared.setContext(context)
    
    print("terms count:", StudyManager.shared.getNextStudyTerms().count)

    return StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
        .environmentObject(NavigationManager())
}
