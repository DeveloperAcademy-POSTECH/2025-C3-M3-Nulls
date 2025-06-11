//
//  StudyTermListView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import CoreData
import SwiftUI

struct StudyCardView: View {
    @AppStorage("selectedGlossaryId") private var selectedGlossaryId: Int = 0
    
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var navigationManager: NavigationManager

    @StateObject private var viewModel = StudyCardViewModel()
    @State private var currentCardIndex: Int? = 0
    @State private var index: Int = 1
    
    @Binding var isStudyInProgress: Bool

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
            if viewModel.terms.count > 0 {
                HStack {
                    ProgressView(value: Double(index), total: Double(viewModel.terms.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.trailing)
                    Text("\(String(format: "%02d", index)) / \(viewModel.terms.count)")
                        .font(.caption)
                        .foregroundStyle(AppColor.primary)
                }
                .padding(.bottom)
                .padding(.horizontal, 15)
                .padding(.top, 30)

                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(Array(viewModel.terms.enumerated()), id: \.offset) { idx, term in
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
                    navigationManager.studyPath.append(.StudyTest(terms: viewModel.terms))
                }
                .font(.body)
                .frame(width: 262, height: 40)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(AppColor.primary)
                .foregroundStyle(AppColor.systemBackground)
                .cornerRadius(16)
                .shadow(radius: 3)
                .opacity(index == viewModel.terms.count ? 1 : 0)
            } else {
                Text("학습할 용어가 없습니다.")
                    .font(.caption)
                    .foregroundStyle(AppColor.grey1)
            }

            Spacer()
        }
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isStudyInProgress = false
                    navigationManager.studyPath = []
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(AppColor.grey3)
                }
            }
        }
        .onAppear {
            viewModel.loadTerms(with: context, existGlossaryId: selectedGlossaryId)
            index = viewModel.terms.isEmpty ? 0 : 1
            currentCardIndex = 0
        }
        .onChange(of: currentCardIndex) {
            if let newIndex = currentCardIndex {
                index = newIndex + 1
            }
        }
        .onChange(of: index) {
            if index > viewModel.terms.count {
                index = viewModel.terms.count
            } else if index < 1 {
                index = 1
            }
        }
    }
}
