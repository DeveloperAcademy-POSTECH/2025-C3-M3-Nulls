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
            Color(red: 0.8, green: 0.86, blue: 0.99)
                .frame(height: 211)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    ZStack{
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
            }.ignoresSafeArea(edges: .top)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 0)
        }
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

    // ✅ 샘플 Glossary 인스턴스 생성
    let sampleGlossary = Glossary(context: context)
    sampleGlossary.title = "샘플 용어집"

    // ✅ 샘플 Term 인스턴스 추가
    let sampleTerm = Term(context: context)
    sampleTerm.spelling = "hypoxia"
    sampleTerm.meaning = "저산소증"
    sampleTerm.abbreviation = "Hx"

    sampleGlossary.addToTerms(sampleTerm)

    return GlossaryDetailView(glossary: sampleGlossary, currentCount: 1, totalCount: 5)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
