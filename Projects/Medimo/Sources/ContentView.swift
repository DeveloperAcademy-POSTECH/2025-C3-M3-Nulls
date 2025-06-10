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
    @State private var isStudyDone = false

    @StateObject private var navigationManager = NavigationManager()

    @StateObject var syncStatus = SyncStatus()
    
    @State private var learningType: LearningType = .study

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
                                    case let .GlossaryDetail(glossary, currentCount, totalCount):
                                        GlossaryDetailView(
                                            glossary: glossary,
                                            currentCount: currentCount,
                                            totalCount: totalCount
                                        )
                                        .environmentObject(navigationManager)

                                    default:
                                        EmptyView()
                                    }
                                }

                            VStack {
                                Spacer()

                                CustomTabBar(selected: $selectedTab)
                                    .padding(.bottom, 24)
                            }
                            .ignoresSafeArea(edges: .bottom)
                        }
                    }

                case .study:
                    NavigationStack(path: $navigationManager.studyPath)
                    {
                        ZStack {
                            StudyView(
                                context: moc,
                                isStudyInProgress: $isStudyInProgress,
                                isStudyDone: $isStudyDone
                            )
                            .environmentObject(navigationManager)
                            .navigationDestination(for: PathType.self) { path in
                                switch path {
                                case .StudyCard:
                                    StudyCardView(
                                        isStudyDone: $isStudyDone,
                                        isStudyInProgress: $isStudyInProgress
                                    )
                                    .environmentObject(navigationManager)
                                    
                                case .StudyCalendar:
                                    StudyCalendarView().environmentObject(navigationManager)
                                    
                                case let .StudyTest(terms):
                                    StudyTestView(
                                        terms: terms,
                                        isStudyInProgress: $isStudyInProgress,
                                        isStudyDone: $isStudyDone,
                                        learningType: $learningType
                                    ).environmentObject(navigationManager)
                                    
                                case .ReviewTest:
                                    ReviewTestView(
                                        isStudyInProgress: $isStudyInProgress,
                                        isStudyDone: $isStudyDone,
                                        learningType: $learningType
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
                                    .padding(.bottom, 24)
                            }
                            .ignoresSafeArea(edges: .bottom)
                        }
                    }
                    .id(isStudyInProgress)
//                    if isStudyInProgress {
//                        NavigationStack(path: $navigationManager.studyPath) {
//                            ZStack {
//                                StudyView(context: moc, isStudyInProgress: $isStudyInProgress, isStudyDone: $isStudyDone)
//                                    .environmentObject(navigationManager)
//                                    .navigationDestination(for: PathType.self) { path in
//                                        switch path {
//                                        case .StudyCard:
//                                            StudyCardView(isStudyDone: $isStudyDone, isStudyInProgress: $isStudyInProgress)
//                                                .environmentObject(navigationManager)
//                                            
//                                        case .StudyCalendar:
//                                            StudyCalendarView().environmentObject(navigationManager)
//                                            
//                                        case let .StudyTest(terms):
//                                            StudyTestView(
//                                                terms: terms,
//                                                isStudyInProgress: $isStudyInProgress, isStudyDone: $isStudyDone, learningType: $learningType
//                                            ).environmentObject(navigationManager)
//                                            
//                                        case .ReviewTest:
//                                            ReviewTestView(
//                                                isStudyInProgress: $isStudyInProgress, isStudyDone: $isStudyDone,
//                                                learningType: $learningType
//                                            ).environmentObject(navigationManager)
//                                            
//                                        case let .TestCompletion(index):
//                                            TestEndView(
//                                                isStudyInProgress: $isStudyInProgress, index: index,
//                                                learningType: $learningType
//                                            ).environmentObject(navigationManager)
//                                            
//                                        default:
//                                            EmptyView()
//                                        }
//                                    }
//
//                                VStack {
//                                    Spacer()
//
//                                    CustomTabBar(selected: $selectedTab)
//                                        .padding(.bottom, 24)
//                                }
//                                .ignoresSafeArea(edges: .bottom)
//                            }
//                        }
//                    } else {
//                        ZStack {
//                            StudyView(context: moc, isStudyInProgress: $isStudyInProgress, isStudyDone: $isStudyDone)
//                                .environmentObject(navigationManager)
//
//                            VStack {
//                                Spacer()
//
//                                CustomTabBar(selected: $selectedTab)
//                                    .padding(.bottom, 24)
//                            }
//                            .ignoresSafeArea(edges: .bottom)
//                        }
//                    }

                case .dictionary:
                    ZStack {
                        DictionaryView()
                            .environmentObject(navigationManager)

                        VStack {
                            Spacer()

                            CustomTabBar(selected: $selectedTab)
                                .padding(.bottom, 24)
                        }
                        .ignoresSafeArea(edges: .bottom)
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
