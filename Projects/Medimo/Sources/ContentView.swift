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
                        VStack {
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

                            CustomTabBar(selected: $selectedTab)
                        }
                    }

                case .study:
                    if isStudyInProgress {
                        NavigationStack(path: $navigationManager.studyPath) {
                            VStack {
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
                                            EmptyView()
                                                    //                                            ReviewTestView(
                                                    //                                                isStudyInProgress: $isStudyInProgress
                                                    //                                            ).environmentObject(navigationManager)

                                        case let .TestCompletion(index):
                                            TestEndView(
                                                isStudyInProgress: $isStudyInProgress,
                                                index: index
                                            ).environmentObject(navigationManager)

                                        default:
                                            EmptyView()
                                        }
                                    }
                                CustomTabBar(selected: $selectedTab)
                            }
                        }
                    } else {
                        VStack {
                            StudyView(isStudyInProgress: $isStudyInProgress)
                                .environmentObject(navigationManager)
                            CustomTabBar(selected: $selectedTab)
                        }
                    }

                case .dictionary:
                    VStack {
                        DictionaryView(context: moc)
                            .environmentObject(navigationManager)
                        CustomTabBar(selected: $selectedTab)
                    } // VStack
                }
            }
            .ignoresSafeArea()

            //            if syncStatus.isSyncing {
            //                VStack {
            //                    Spacer()
            //
            //                    HStack(spacing: 12) {
            //                        ProgressView()
            //                            .progressViewStyle(CircularProgressViewStyle(tint: AppColor.white))
            //                            .frame(width: 24, height: 24)
            //                        Text("데이터를 가져오고 있어요...")
            //                            .foregroundStyle(AppColor.white)
            //                    }
            //                    .padding(30)
            //                    .background(
            //                        RoundedRectangle(cornerRadius: 16)
            //                            .fill(AppColor.navy)
            //                    )
            //
            //                    Spacer()
            //                }
            //                .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                .background(Color.black.opacity(0.45))
            //                .edgesIgnoringSafeArea(.all)
            //            }
        } // ZStack
        .onAppear {
//            Task {
//                if coreDataManager.needsInitialCloudKitFetch(context: moc) {
//                    await coreDataManager.initialize()
//                }
//            }

            // Check iCloud
            if cloudKitManager.isICloudAvailable() {
                print("☁️ iCloud is available")
            } else {
                print("☁️ iCloud is not available")
            }
        }
//        .overlay(
//            cloudKitManager.accountStatus != .available
//            ? AnyView(iCloudStatusOverlay(accountStatus: cloudKitManager.accountStatus))
//                : AnyView(EmptyView())
//        )
    }
}

#Preview {
    ContentView(context: CoreDataManager.preview.container.viewContext)
        .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
