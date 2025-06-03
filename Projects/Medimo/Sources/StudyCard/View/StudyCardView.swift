//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//
import CoreData
import SwiftUI

struct StudyCardView: View {
    @Environment(\.managedObjectContext) private var context

    @Bindable private var viewModel: StudyCardViewModel
    @State private var index: Int

    init(glossary: Glossary) {
        _viewModel = .init(wrappedValue: StudyCardViewModel(glossary: glossary, studyTermSize: 5))
        index = 5
    }

    var body: some View {
        VStack {
            HStack {
                ProgressView(value: Double(index) / Double(viewModel.studyTermSize))
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.trailing)

                Text("\(String(format: "%02d", index)) / \(viewModel.studyTermSize)")
                    .font(.MM_AT)
                    .foregroundColor(Color("MM_Navy"))
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

            Button("용어 테스트 시작") {
                // TODO: 액션 정의
            }
            .font(.MM_Pr)
            .frame(width: 262, height: 40)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(Color("MM_Navy"))
            .foregroundColor(Color("MM_White"))
            .cornerRadius(16)
            .shadow(radius: 3)
            .opacity(viewModel.studyTermSize == index ? 1 : 0)

            Spacer()
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 20)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]

    StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
}
