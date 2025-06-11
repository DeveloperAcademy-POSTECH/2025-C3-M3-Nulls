//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//  Edited by Ell 6/5/

import CoreData
import SwiftUI

struct GlossaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var navigationManager: NavigationManager

    @Bindable var viewModel: GlossaryDetailViewModel

    init(glossary: Glossary, currentCount: Int, totalCount: Int) {
        _viewModel = Bindable(wrappedValue: GlossaryDetailViewModel(
            glossary: glossary,
            currentCount: currentCount,
            totalCount: totalCount
        ))
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(AppColor.skyBlue)
                .frame(height: 211)
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    ZStack {
                        GlossaryHeaderView(
                            title: viewModel.glossary.title ?? "제목 없음",
                            lastStudiedAt: viewModel.lastStudiedAt,
                            currentCount: viewModel.currentCount,
                            totalCount: viewModel.totalCount,
                            scrollOffset: 0
                        )
                    }
                    GlossaryFilterToggle(selectedFilter: $viewModel.termStudyFilter)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 15)

                if viewModel.filteredTerms.count > 0 {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.filteredTerms.sorted(by: { $0.spelling ?? "" < $1.spelling ?? "" })) { term in
                                Button {
                                    viewModel.selectedTerm = term
                                } label: {
                                    GlossaryTermCard(
                                        spelling: term.spelling ?? "",
                                        abbreviation: term.abbreviation,
                                        meaning: term.meaning ?? ""
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 20)
                    }
                } else {
                    Spacer()
                    Text(viewModel.termStudyFilter == .learned ? "아직 학습한 단어가 없어요" : "모든 단어들을 학습했어요!")
                        .font(.caption)
                        .foregroundStyle(AppColor.grey3)
                    Spacer()
                }
            }.ignoresSafeArea(edges: .top)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 0)
        }
        .background(AppColor.white)
        .navigationBarBackButtonHidden()
        .sheet(item: $viewModel.selectedTerm) { term in
            DictionaryDetailView(term: term)
                .presentationDetents([.height(640)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext

    let sampleGlossary = Glossary(context: context)
    sampleGlossary.title = "샘플 용어집"

    let sampleTerm = Term(context: context)
    sampleTerm.spelling = "hypoxia"
    sampleTerm.meaning = "저산소증"
    sampleTerm.abbreviation = "Hx"

    sampleGlossary.addToTerms(sampleTerm)

    return GlossaryDetailView(glossary: sampleGlossary, currentCount: 1, totalCount: 5)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
