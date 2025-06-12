//
//  ContentView.swift
//  Projects
//
//  Created by 김현기 on 6/9/25.
//

import CoreData
import SwiftUI

public struct ContentView: View {
    @AppStorage("selectedGlossaryId") private var selectedGlossaryId: Int = 0

    @Environment(\.managedObjectContext) var moc
    let coreDataManager = CoreDataManager.shared
    let cloudKitManager = CloudKitManager.shared

    @State private var selectedTab: TabType = .study
    @State private var isStudyInProgress = true

    @StateObject private var navigationManager = NavigationManager()

    @StateObject var syncStatus = SyncStatus()

    @State private var learningType: LearningType = .study
    
    @State private var isAnswered: Bool = false

    init(context: NSManagedObjectContext) {
        let studyManager = StudyManager.shared
        
        studyManager.setContext(context, selectedGlossaryId)

        studyManager.countCurrentStreakAndSave()
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .glossary:
                NavigationStack(path: $navigationManager.glossaryPath) {
                    ZStack {
                        GlossaryListView(context: moc)
                            .environmentObject(navigationManager)
                            .navigationDestination(for: PathType.self) { path in
                                switch path {
                                case let .GlossaryDetail(glossary, currentCount, totalCount):
                                    GlossaryDetailView(
                                        glossary: glossary,
                                        currentCount: currentCount,
                                        totalCount: totalCount
                                    )
                                    .environmentObject(navigationManager)

                                case .BookmarkDetail:
                                    BookmarkDetailView()
                                        .environmentObject(navigationManager)

                                default:
                                    EmptyView()
                                }
                            }
                        VStack {
                            Spacer()

                            CustomTabBar(selected: $selectedTab)
                                .padding(.bottom, 16)
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }

            case .study:
                NavigationStack(path: $navigationManager.studyPath) {
                    ZStack {
                        StudyView(
                            context: moc,
                            isStudyInProgress: $isStudyInProgress
                        )
                        .environmentObject(navigationManager)
                        .navigationDestination(for: PathType.self) { path in
                            switch path {
                            case .StudyCard:
                                StudyCardView(isStudyInProgress: $isStudyInProgress)
                                    .environmentObject(navigationManager)

                            case .StudyCalendar:
                                StudyCalendarView().environmentObject(navigationManager)

                            case let .StudyTest(terms):
                                StudyTestView(
                                    terms: terms,
                                    isStudyInProgress: $isStudyInProgress,
                                    learningType: $learningType, isAnswered: $isAnswered
                                ).environmentObject(navigationManager)

                            case .ReviewTest:
                                ReviewTestView(
                                    isStudyInProgress: $isStudyInProgress,
                                    learningType: $learningType, isAnswered: $isAnswered
                                ).environmentObject(navigationManager)

                            case let .TestCompletion(index):
                                TestEndView(
                                    isStudyInProgress: $isStudyInProgress,
                                    index: index,
                                    learningType: $learningType
                                ).environmentObject(navigationManager)

                            default:
                                EmptyView()
                            }
                        }

                        VStack {
                            Spacer()
                            CustomTabBar(selected: $selectedTab)
                                .padding(.bottom, 16)
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
                .id(isStudyInProgress)

            case .dictionary:
                ZStack {
                    DictionaryView()
                        .environmentObject(navigationManager)

                    VStack {
                        Spacer()
                        CustomTabBar(selected: $selectedTab)
                            .padding(.bottom, 16)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
            }
        }
    }
}

#Preview {
    ContentView(context: CoreDataManager.preview.container.viewContext)
        .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
