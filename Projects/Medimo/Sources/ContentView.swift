import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedTab: TabType = .study

    @StateObject private var navigationManager = NavigationManager()

    public var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .glossary:
                NavigationStack(path: $navigationManager.glossaryPath) {
                    GlossaryListView(context: context)
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
                } // NavigationStack

            case .study:
                NavigationStack(path: $navigationManager.studyPath) {
                    StudyView(glossary: try! context.fetch(Glossary.fetchRequest())[0])
                        .environmentObject(navigationManager)
                        .navigationDestination(for: PathType.self) { path in
                            switch path {
                            case let .StudyCard(glossary):
                                StudyCardView(glossary: glossary)

                            case .StudyCalendar:
                                StudyCalendarView()
                                    .environmentObject(navigationManager)

                            default:
                                EmptyView()
                            }
                        }
                } // NavigationStack

            case .dictionary:
                DictionaryView(context: context)
                    .environmentObject(navigationManager)
            }

//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if selectedTab != .study || navigationManager.studyPath.isEmpty {
                CustomTabBar(selected: $selectedTab)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .padding(.bottom, 1)

//        TabView(selection: $selectedTab) {
//            Tab("용어집", systemImage: "book", value: .glossary) {
//                NavigationStack(path: $glossaryNavigationManager.path) {
//                    GlossaryListView(context: context)
//                        .environmentObject(glossaryNavigationManager)
//                        .navigationDestination(for: PathType.self) { path in
//                            switch path {
//                            case let .GlossaryDetail(glossary):
//                                GlossaryDetailView(glossary: glossary)
//                                    .environmentObject(glossaryNavigationManager)
//
//                            default:
//                                EmptyView()
//                            }
//                        }
//                }
//            }
//
//            Tab("학습", systemImage: "book", value: .study) {
//                NavigationStack(path: $studyNavigationManager.path) {
//                    // TODO: StudyManager 구현하여 수정해야 함
//                    StudyView(glossary: try! context.fetch(Glossary.fetchRequest())[0])
//                        .environmentObject(studyNavigationManager)
//                        .navigationDestination(for: PathType.self) { path in
//                            switch path {
//                            case .StudyCard(let glossary):
//                                StudyCardView(glossary: glossary)
//                                    .environmentObject(studyNavigationManager)
//
//                            case let .StudyTest(terms):
//                                StudyTestView(terms: terms)
        ////
        ////                            case let .ReviewTest(glossary):
        ////                                EmptyView()
        ////
        ////                            case .TestCompletion:
        ////                                EmptyView()
//
//                            default:
//                                EmptyView()
//                            }
//                        }
//                }
//                .navigationBarBackButtonHidden()
//            }
//
//            Tab("사전", systemImage: "book", value: .dictionary) {
//                DictionaryView(context: context)
//                    .environmentObject(dictionaryNavigationManager)
//            }
//        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
