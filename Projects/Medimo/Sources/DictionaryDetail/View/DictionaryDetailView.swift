//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData
import SwiftUI

struct DictionaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    let coreDataManager = CoreDataManager.shared

    @State var viewModel: DictionaryDetailViewModel

    init(term: Term) {
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? context.fetch(fetchRequest)) ?? []
        return users.first ?? User(context: context)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()

                    DictionaryDetailViewComponents.characterImage()
                } // VStack
                .background(AppColor.white)

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            // MARK: - - 사운드, 북마크

                            HStack {
                                DictionaryDetailViewComponents.soundButton(
                                    spelling: viewModel.term.spelling
                                ) {
                                    if let spelling = viewModel.term.spelling {
                                        viewModel.speak(spelling)
                                    }
                                }
                                Spacer()
                                BookmarkButtonView(user: user, term: viewModel.term)
                            } // HStack
                            .padding(.top, 48)
                            .padding(.bottom, 20)

                            // MARK: - - 용어, 약어, 분과

                            VStack(alignment: .leading) {
                                Text(viewModel.term.spelling ?? "")
                                    .font(.titleEng)
                                    .foregroundColor(AppColor.label)
                                    .padding(.bottom, 8)
                                if let abbreviation = viewModel.term.abbreviation {
                                    if !abbreviation.isEmpty {
                                        Text("[ \(abbreviation) ]")
                                            .font(.titleEng)
                                            .foregroundColor(AppColor.label)
                                    }
                                }
                                DictionaryDetailViewComponents.sectionGlossary(viewModel.term.glossaries)

                                DictionaryDetailViewComponents.sectionRectangle()
                            } // VStack
                        } // VStack
                        .padding(.horizontal, 32)

                        // MARK: - - 의미

                        DictionaryDetailViewComponents.meaningSection(viewModel.term.meaning)

                        // MARK: - - 어원

                        if let morphemes = (viewModel.term.morphemes)?.array as? [Morpheme], !morphemes.isEmpty {
                            DictionaryDetailViewComponents.morphemeSection(morphemes)
                        }
                        //                    if let morphemes = viewModel.term.morphemes as? Set<Morpheme>, !morphemes.isEmpty {
                        //                        DictionaryDetailViewComponents.morphemeSection(morphemes)
                        //                    }

                        // MARK: - - 설명

                        DictionaryDetailViewComponents.explanationSection(viewModel.term.explanation)

                        Spacer()
                    } // ScrollView
                } // VStack
                
            } // ZStack
        } // NavigationStack
    }
}

#Preview {
    DictionaryDetailView(
        term: try! CoreDataManager.preview.container.viewContext.fetch(Term.fetchRequest())[6]
    )
    .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
