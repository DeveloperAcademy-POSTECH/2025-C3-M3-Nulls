import SwiftUI
import CoreData

public struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedTab: TabType = .study
    
    @StateObject private var navigationManager = NavigationManager()
    
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

                            CustomTabBar(selected: $selectedTab)
                        }
                    } // NavigationStack

                case .study:
                    NavigationStack(path: $navigationManager.studyPath) {
                        VStack {
                            StudyView()
                                .environmentObject(navigationManager)
                                .navigationDestination(for: PathType.self) { path in
                                    switch path {
                                    case /*let*/ .StudyCard:
                                        StudyCardView()
                                            .environmentObject(navigationManager)

                                    case .StudyCalendar:
                                        StudyCalendarView()
                                            .environmentObject(navigationManager)

                                    case let .StudyTest(terms):
                                        StudyTestView(terms: terms)
                                            .environmentObject(navigationManager)
                                        
                                    case let .TestCompletion(index):
                                        TestEndView(index: .constant(index))
                                            .environmentObject(navigationManager)


                                    default:
                                        EmptyView()
                                    }
                                }

                            CustomTabBar(selected: $selectedTab)
                        }
                    } // NavigationStack

                case .dictionary:
                    VStack {
                        DictionaryView(context: context)
                            .environmentObject(navigationManager)

                        CustomTabBar(selected: $selectedTab)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(context: PersistenceController.preview.container.viewContext)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
