import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedTab: TabType = .study

    @StateObject private var glossaryNavigationManager = NavigationManager()
    @StateObject private var studyNavigationManager = NavigationManager()
    @StateObject private var dictionaryNavigationManager = NavigationManager()

    public var body: some View {
        TabView(selection: $selectedTab) {
            Tab("용어집", systemImage: "book", value: .glossary) {
                NavigationStack(path: $glossaryNavigationManager.path) {
                    GlossaryListView(context: context)
                        .environmentObject(glossaryNavigationManager)
                        .navigationDestination(for: PathType.self) { path in
                            switch path {
                            case let .GlossaryDetail(glossary):
                                GlossaryDetailView(glossary: glossary)
                                    .environmentObject(glossaryNavigationManager)

                            default:
                                EmptyView()
                            }
                        }
                }
            }

            Tab("학습", systemImage: "book", value: .study) {
                NavigationStack(path: $studyNavigationManager.path) {
                    // TODO: StudyManager 구현하여 수정해야 함
                    StudyView(glossary: try! context.fetch(Glossary.fetchRequest())[0])
                        .environmentObject(studyNavigationManager)
                        .navigationDestination(for: PathType.self) { path in
                            switch path {
                            case let .StudyCard(glossary):
                                StudyCardView(glossary: glossary)
                                    .environmentObject(studyNavigationManager)

//                            case let .StudyTest(glossary):
//                                EmptyView()
//
//                            case let .ReviewTest(glossary):
//                                EmptyView()
//
//                            case .TestCompletion:
//                                EmptyView()

                            default:
                                EmptyView()
                            }
                        }
                }
            }

            Tab("사전", systemImage: "book", value: .dictionary) {
                DictionaryView()
                    .environmentObject(dictionaryNavigationManager)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
