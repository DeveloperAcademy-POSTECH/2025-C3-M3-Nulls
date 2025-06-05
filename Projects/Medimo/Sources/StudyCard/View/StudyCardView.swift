import CoreData
import SwiftUI



struct StudyCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) private var context

    @Bindable private var viewModel: StudyCardViewModel
  
    @State private var currentCardIndex: Int = 0
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
    
    func colorForPosition(_ position: CardBackgroundModifier.CardPosition) -> Color {
        switch position {
        case .center:
            return Color.white
        case .left:
            return AppColor.blue
        case .right:
            return AppColor.skyBlue
        }
    }
    
    var body: some View {
        VStack {
            if studyTermSize > 0 {
                HStack {
                    ProgressView(value: Double(index), total: Double(studyTermSize))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.trailing)
                    Text("\(String(format: "%02d", index)) / \(studyTermSize)")
                        .font(.caption)
                        .foregroundStyle(AppColor.primary)
                }
                .padding(.bottom)
                .padding(.horizontal, 15)
                .padding(.top, 30)
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(Array(terms.enumerated()), id: \.offset) { idx, term in
                            let position = viewModel.cardPosition(for: idx, currentIndex: currentCardIndex)
                            let color = colorForPosition(position)
                            TermCardView(term: term, backgroundColor: color)
                                .modifier(CardBackgroundModifier(position: position))
                                .id(idx)
                                .animation(.easeInOut(duration: 0.15), value: currentCardIndex)
                                .frame(width: UIScreen.main.bounds.width - 64)
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(y: phase.isIdentity ? 1 : 0.85)
                                }
                        }
                        Color.clear
                            .frame(width: 30) // Add trailing space to prevent clipping
                    }
                    .padding(.leading, 35)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $currentCardIndex, anchor: .center)
                
                Spacer()
                
                Button("용어 테스트 시작") {
                    navigationManager.push(to: .StudyTest(terms: terms))
                }
                .font(.body)
                .frame(width: 262, height: 40)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(AppColor.primary)
                .foregroundStyle(AppColor.systemBackground)
                .cornerRadius(16)
                .shadow(radius: 3)
                .opacity(index == studyTermSize ? 1 : 0) // 마지막 카드에서만 보이도록
            } else {
                Text("학습할 용어가 없습니다.")
                    .font(.caption)
                    .foregroundStyle(AppColor.grey1)
            }
            
            Spacer()
        }
        .padding(.bottom, 20)
        .onAppear {
            StudyManager.shared.setContext(context)
            if studyTermSize == 0 {
                index = 0
            } else {
                index = 1 // 첫 번째 카드를 1로 표시
            }
            currentCardIndex = 0
        }
        .onChange(of: currentCardIndex) {
            if let newIndex = currentCardIndex {
                index = newIndex + 1
            }
        }
        // index 범위 초과 방지 로직은 유지하는 것이 좋습니다.
        .onChange(of: index) { newValue in
            if studyTermSize > 0 { // 용어가 있을 때만 범위 조정
                if newValue > studyTermSize {
                    index = studyTermSize
                } else if newValue < 1 {
                    index = 1
                }
            } else {
                if newValue != 0 { // 용어가 없으면 index는 0이어야 함
                    index = 0
                }
            }
        }
    }
}

// Preview는 그대로 유지됩니다.
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
  
    return StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
        .environmentObject(NavigationManager())
}
