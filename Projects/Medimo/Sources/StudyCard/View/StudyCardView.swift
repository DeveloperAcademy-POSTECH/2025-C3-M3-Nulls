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
    @EnvironmentObject var navigationManager: NavigationManager

    @StateObject private var viewModel: StudyCardViewModel
    @State private var currentCardIndex: Int? = 0
    @State private var index: Int = 1

    var terms: [Term] {
        StudyManager.shared.getNextStudyTerms()
    }

    init() {
        _viewModel = .init(wrappedValue: StudyCardViewModel())
    }

    func colorForPosition(_ position: CardBackgroundModifier.CardPosition) -> Color {
        switch position {
        case .center:
            return AppColor.white
        case .left:
            return AppColor.blue
        case .right:
            return AppColor.skyBlue
        }
    }

    var body: some View {
        VStack {
            if terms.count > 0 {
                HStack {
                    ProgressView(value: Double(index), total: Double(terms.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.trailing)
                    Text("\(String(format: "%02d", index)) / \(terms.count)")
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
                            .frame(width: 30)
                    }
                    .padding(.leading, 35)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .scrollPosition(id: $currentCardIndex, anchor: .center)

                Spacer()

                Button("용어 테스트 시작") {
                    navigationManager.studyPath.append(.StudyTest(terms: terms))
                }
                .font(.body)
                .frame(width: 262, height: 40)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(AppColor.primary)
                .foregroundStyle(AppColor.systemBackground)
                .cornerRadius(16)
                .shadow(radius: 3)
                .opacity(index == terms.count ? 1 : 0)
            } else {
                Text("학습할 용어가 없습니다.")
                    .font(.caption)
                    .foregroundStyle(AppColor.grey1)
            }

            Spacer()
        }
        .padding(.bottom, 20)
        .onAppear {
            if terms.count == 0 {
                index = 0
            } else {
                index = 1
            }
            currentCardIndex = 0
        }
        .onChange(of: currentCardIndex) {
            if let newIndex = currentCardIndex {
                index = newIndex + 1
            }
        }
        .onChange(of: index) {
            if index > terms.count {
                index = terms.count
            } else if index < 1 {
                index = 1
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var navigationManager = NavigationManager()
    let context = PersistenceController.preview.container.viewContext

    var studyManager = StudyManager.shared
    studyManager.setContext(context)
    print("terms count:", studyManager.getNextStudyTerms().count)
    
    
    return StudyCardView()
        .environment(\.managedObjectContext, context)
        .environmentObject(navigationManager)
}
