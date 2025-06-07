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
    
    @State var glossaryFilter: GlossaryTermFilter = .learned
    
    @State var viewModel: GlossaryDetailViewModel
    
    init(glossary: Glossary) {
        _viewModel = State(wrappedValue: GlossaryDetailViewModel(glossary: glossary))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(red: 0.8, green: 0.86, blue: 0.99)
                .frame(height: 211)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    ZStack{
                        GlossaryHeaderView(title: viewModel.glossary.title ?? "제목 없음", scrollOffset: 0)
                    }
                    GlossaryFilterToggle(selectedFilter: $glossaryFilter)
                        .padding(.horizontal, 17)
                }
                .padding(.bottom, 15)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.getTerms()) { term in
                            Button {
                                navigationManager.glossaryPath.append(.StudyCard)
                            } label: {
                                GlossaryTermCard(
                                    spelling: term.spelling ?? "",
                                    abbreviation: term.abbreviation,
                                    meaning: term.meaning ?? ""
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                }
            }.ignoresSafeArea(edges: .top)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 0)
        }
    }
}

    
    
#Preview {
    let context = PersistenceController.preview.container.viewContext

    // ✅ 샘플 Glossary 인스턴스 생성
    let sampleGlossary = Glossary(context: context)
    sampleGlossary.title = "샘플 용어집"

    // ✅ 샘플 Term 인스턴스 추가
    let sampleTerm = Term(context: context)
    sampleTerm.spelling = "hypoxia"
    sampleTerm.meaning = "저산소증"
    sampleTerm.abbreviation = "Hx"

    sampleGlossary.addToTerms(sampleTerm)

    return GlossaryDetailView(glossary: sampleGlossary)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
