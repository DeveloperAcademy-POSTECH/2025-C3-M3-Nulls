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
    @State private var selectedCategory: String = "전체"

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
                        .padding(.horizontal, 24)
                    GlossaryCategoryBar(selectedCategory: $selectedCategory)
                        .padding(.horizontal, 16)
                }
                .background(AppColor.secondarySystemFill)
                .frame(maxWidth: .infinity, alignment: .leading)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(viewModel.glossaries) { glossary in
                            Button {
                                navigationManager.glossaryPath.append(.GlossaryDetail(glossary: glossary))
//                                navigationManager.push(to: .GlossaryDetail(glossary: glossary))
                            } label: {
                                GlossaryCardView(
                                    title: glossary.title ?? "알 수 없음",
                                    currentCount: 1,
                                    totalCount: 200
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 32)
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    GlossaryListView(context: context)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
