import SwiftUI

public struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @State private var selectedTab: TabType = .study

     public var body: some View {
         TabView(selection: $selectedTab) {
             Tab("용어집", systemImage: "book", value: .glossary) {
                 GlossaryListView(context: context)
             }
             
             Tab("학습", systemImage: "book", value: .study) {
                 // TODO: StudyManager 구현하여 수정해야 함
                 StudyView(glossary: try! context.fetch(Glossary.fetchRequest())[0])
             }
             
             Tab("사전", systemImage: "book", value: .dictionary) {
                 DictionaryView(context: context)
             }
         }
     }
 }

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
