//
//  BookmarkDetailView.swift
//  Medimo
//
//  Created by 김현기 on 6/11/25.
//

import CoreData
import SwiftUI

struct BookmarkDetailView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var navigationManager: NavigationManager

    let studyManager = StudyManager.shared

    @State var selectedTerm: Term?

    var bookmarks: [Term] {
        if let bookmarks = studyManager.user.bookmarks as? Set<Term> {
            let bookmarkArray = Array(bookmarks)

            return bookmarkArray.sorted { $0.spelling ?? "" < $1.spelling ?? "" }
        }

        return []
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(AppColor.skyBlue)
                .frame(height: 150)
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    ZStack {
                        BookmarkHeaderView(
                            title: "북마크",
                            totalCount: studyManager.user.bookmarks?.count ?? 0,
                            scrollOffset: 0
                        )
                    }
                }
                .padding(.bottom, 15)

                ScrollView {
                    LazyVStack(spacing: 0) {
                        if bookmarks.isEmpty {
                            VStack {
                                Spacer()
                                Text("북마크가 없습니다.")
                                    .font(.headline)
                                    .foregroundStyle(AppColor.label)
                                    .padding(.top, 100)
                            }
                        }
                        ForEach(bookmarks) { term in
                            Button {
                                selectedTerm = term
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
        .background(AppColor.white)
        .navigationBarBackButtonHidden()
        .sheet(item: $selectedTerm) { term in
            DictionaryDetailView(term: term)
                .presentationDetents([.height(640)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct BookmarkHeaderView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    let title: String
    let totalCount: Int
    let scrollOffset: CGFloat

    var body: some View {
//        ZStack(alignment: .bottom) {
//            AppColor.secondarySystemFill

        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 40) {
                HStack(spacing: 10) {
                    HStack {
                        Button(action: {
                            navigationManager.glossaryPath.removeLast()
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20, weight: .medium))
                        }
                        Text(title)
                            .font(.largeTitle)
                    }

                    Spacer()

                    HStack(spacing: 3) {
                        Text("총 \(totalCount)개")
                            .font(.headline)
                            .foregroundStyle(AppColor.textColor)
                    }
                    .padding(.horizontal, 4)
                }
                .foregroundStyle(AppColor.textColor)
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 90)
        .padding(.bottom, 16)
    }
}

// #Preview {
//    BookmarkDetailView()
//        .environmentObject(NavigationManager())
// }
