//
//  ContentView.swift
//  Projects
//
//  Created by 김현기 on 6/9/25.
//

import CoreData
import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    let coreDataManager = CoreDataManager.shared
    let cloudKitManager = CloudKitManager.shared

    @State private var selectedTab: TabType = .study
    @State private var isStudyInProgress = true

    @StateObject private var navigationManager = NavigationManager()

    @StateObject var syncStatus = SyncStatus()

    init(context: NSManagedObjectContext) {
        let studyManager = StudyManager.shared
        studyManager.setContext(context)
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                switch selectedTab {
                case .glossary:
                    NavigationStack(path: $navigationManager.glossaryPath) {
                        ZStack {
                            GlossaryListView(context: moc)
                                .environmentObject(navigationManager)
                                .navigationDestination(for: PathType.self) { path in
                                    switch path {
                                    case let .GlossaryDetail(glossary):
                                        GlossaryDetailView(glossary: glossary)
                                            .environmentObject(navigationManager)

                                    default:
                                        EmptyView()
                                    }
                                }

                            VStack {
                                Spacer()

                                CustomTabBar(selected: $selectedTab)
                            }
                        }
                    }

                case .study:
                    if isStudyInProgress {
                        NavigationStack(path: $navigationManager.studyPath) {
                            ZStack {
                                StudyView(isStudyInProgress: $isStudyInProgress)
                                    .environmentObject(navigationManager)
                                    .navigationDestination(for: PathType.self) { path in
                                        switch path {
                                        case .StudyCard:
                                            StudyCardView().environmentObject(navigationManager)

                                        case .StudyCalendar:
                                            StudyCalendarView().environmentObject(navigationManager)

                                        case let .StudyTest(terms):
                                            StudyTestView(
                                                terms: terms,
                                                isStudyInProgress: $isStudyInProgress
                                            ).environmentObject(navigationManager)

                                        case .ReviewTest:
                                            ReviewTestView(
                                                isStudyInProgress: $isStudyInProgress
                                            ).environmentObject(navigationManager)

                                        case let .TestCompletion(index):
                                            TestEndView(
                                                isStudyInProgress: $isStudyInProgress, index: index
                                            ).environmentObject(navigationManager)

                                        default:
                                            EmptyView()
                                        }
                                    }

                                VStack {
                                    Spacer()

                                    CustomTabBar(selected: $selectedTab)
                                }
                            }
                        }
                    } else {
                        ZStack {
                            StudyView(isStudyInProgress: $isStudyInProgress)
                                .environmentObject(navigationManager)

                            VStack {
                                Spacer()

                                CustomTabBar(selected: $selectedTab)
                            }
                        }
                    }

                case .dictionary:
                    ZStack {
                        DictionaryView()
                            .environmentObject(navigationManager)

                        VStack {
                            Spacer()

                            CustomTabBar(selected: $selectedTab)
                                .padding(.bottom, 34)
                        }
                    } // VStack
                }
            }
        } // ZStack
        .onAppear {
            // TEST
            let userFetchRequest: NSFetchRequest<User> = User.fetchRequest()
            userFetchRequest.fetchLimit = 1
            _ = (try? coreDataManager.context.fetch(userFetchRequest).first) ?? User(context: coreDataManager.context)
        }
    }
}

#Preview {
    ContentView(context: CoreDataManager.preview.container.viewContext)
        .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
