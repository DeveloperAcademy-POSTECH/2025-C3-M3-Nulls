import SwiftUI

 public struct ContentView: View {
     @Environment(\.managedObjectContext) var context

     public var body: some View {
         TabView {
             Tab("용어집", systemImage: "book") {
                 GlossaryListView(context: context)
             }
             Tab("학습", systemImage: "book") {
                 // TODO: StudyManager 구현하여 수정해야 함
                 StudyView(glossary: try! context.fetch(Glossary.fetchRequest())[0])
             }
             Tab("사전", systemImage: "book") {
                 DictionaryView()
             }
         }
     }
 }

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
