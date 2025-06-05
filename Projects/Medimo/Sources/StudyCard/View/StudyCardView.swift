import CoreData
import SwiftUI

struct StudyCardView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.managedObjectContext) private var context

    @Bindable private var viewModel: StudyCardViewModel
    @State private var currentCardIndex: Int = 0 // TabView selection을 위해 Int로 변경
    @State private var index: Int = 1

    var terms: [Term] {
        viewModel.getStudyTerms()
    }

    var studyTermSize: Int {
        terms.count
    }

    // ViewModel이 glossary를 사용해야 한다면, init에서 전달해야 합니다.
    // 현재 ViewModel()은 glossary를 받지 않고 있습니다. 이 부분은 원본 코드의 동작에 따라
    // StudyCardViewModel의 init을 수정하거나, 여기서 glossary를 전달하도록 변경해야 할 수 있습니다.
    init(glossary _: Glossary) {
        // 예시: _viewModel = .init(wrappedValue: StudyCardViewModel(glossary: glossary))
        _viewModel = .init(wrappedValue: StudyCardViewModel())
    }

    var body: some View {
        VStack {
            if studyTermSize > 0 {
                // 진행률 표시 바 및 인덱스
                HStack {
                    ProgressView(value: Double(index), total: Double(studyTermSize))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.trailing)
                    Text("\(String(format: "%02d", index)) / \(studyTermSize)")
                        .font(.caption)
                        .foregroundStyle(AppColor.primary)
                }
                .padding(.bottom)
                .padding(.top, 40)

                // TabView로 카드 표시
                TabView(selection: $currentCardIndex) {
                    ForEach(Array(terms.enumerated()), id: \.offset) { idx, term in
                        TermCardView(term: term)
                            // .id(idx) // ForEach에는 필요하지만 TabView selection에는 tag 사용
                            .frame(width: UIScreen.main.bounds.width - 100, height: 400)
                            // TabView는 scrollTransition과 같은 phase 기반 전환을 직접 제공하지 않음
                            // 필요하다면 currentCardIndex를 사용하여 유사한 효과를 줄 수 있음:
                            .opacity(idx == currentCardIndex ? 1.0 : 0.6) // 예시: 활성/비활성 카드 투명도
                            .scaleEffect(idx == currentCardIndex ? 1.0 : 0.9) // 예시: 활성/비활성 카드 크기
                            .tag(idx) // TabView selection을 위해 각 뷰에 tag 설정
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // 페이지 스타일, 인디케이터 숨김
                .frame(height: 550) // 카드 높이(400)와 약간의 여유 공간 고려. 필요에 따라 조절.
                // 원래 ScrollView에 있던 .padding(.top, 40)과는 별개로
                // TabView 자체의 컨텐츠 영역 높이 설정
                .padding(.top, 20) // 진행률 바와 TabView 사이의 간격 (기존 ScrollView의 .padding(.top, 40)을 대체 또는 조절)

                Spacer()

                // 용어 테스트 시작 버튼
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
                Spacer() // 내용이 없을 때도 중앙 정렬을 위해 Spacer 추가 가능
            }
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 20)
        .onAppear {
            StudyManager.shared.setContext(context)
            if studyTermSize == 0 {
                index = 0
            } else {
                index = 1 // 첫 번째 카드를 1로 표시
            }
            currentCardIndex = 0 // 첫 번째 탭으로 시작
        }
        .onChange(of: currentCardIndex) { newValue in // iOS 17+ (oldValue, newValue in)
            // TabView의 selection이 변경될 때 index 업데이트
            index = newValue + 1
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
    let context = PersistenceController.shared.container.viewContext

    let glossary = Glossary(context: context)
    glossary.id = UUID()
    glossary.title = "프리뷰 용어집"

    // 여러 개의 Term을 추가하여 TabView 테스트 용이하게
    for i in 1 ... 3 {
        let term = Term(context: context)
        term.id = UUID()
        term.spelling = "Preview Term \(i)"
        term.meaning = "미리보기 용어 \(i)의 의미입니다. 이 설명은 카드에 표시될 내용입니다."
        glossary.addToTerms(term)
    }

    try? context.save()

    StudyManager.shared.setContext(context)

    // StudyManager에서 glossary에 기반한 terms를 가져오도록 설정했다고 가정
    // print("terms count:", StudyManager.shared.getNextStudyTerms().count) // 이 부분은 ViewModel 로직에 따라 달라질 수 있음

    return StudyCardView(glossary: glossary)
        .environment(\.managedObjectContext, context)
        .environmentObject(NavigationManager())
}
