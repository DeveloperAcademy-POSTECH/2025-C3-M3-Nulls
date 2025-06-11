//
//  GlossaryListView.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import CoreData
import SwiftUI

struct GlossaryListView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var viewModel: GlossaryListViewModel
    @State private var selectedCategory: MedicineCategory = .all

    let studyManager = StudyManager.shared

    var filteredGlossaries: [Glossary] {
        if selectedCategory == .all {
            viewModel.glossaries
        } else {
            viewModel.glossaries.filter {
                $0.category == selectedCategory.rawValue
            }
        }
    }

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24),
    ]

    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: GlossaryListViewModel(context: context))
    }

    @State private var rowHeight: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 28) {
                    Text("단어장")
                        .font(.largeTitle)
                        .foregroundStyle(AppColor.label)
                        .padding(.top, 28)
                        .padding(.leading, 22)
                    GlossaryCategoryBar(selectedCategory: $selectedCategory)
                }
                .background(AppColor.secondarySystemFill)
                .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        if selectedCategory == .all {
                            Button {
                                navigationManager.glossaryPath.append(
                                    .BookmarkDetail
                                )
                            } label: {
                                BookmarkCardView(
                                    title: "북마크",
                                    totalCount: studyManager.user.bookmarks?.count ?? 0
                                )
                            }                            
                        }
                        ForEach(filteredGlossaries) { glossary in
                            let currentCount = Int(viewModel.user.progressForGlossary(glossary.id)?.studiedCount ?? 0)
                            let totalCount = glossary.terms?.count ?? 0
                            Button {
                                navigationManager.glossaryPath.append(
                                    .GlossaryDetail(
                                        glossary: glossary,
                                        currenctCount: currentCount,
                                        totalCount: totalCount
                                    )
                                )
                            } label: {
                                GlossaryCardView(
                                    title: glossary.title ?? "알 수 없음",
                                    currentCount: currentCount,
                                    totalCount: totalCount
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 32)
                    .padding(.bottom, 68)
                }
            }
            .background(AppColor.white)
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext
    GlossaryListView(context: context)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
