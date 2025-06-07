import SwiftUI

@main
struct MedimoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(context: persistenceController.container.viewContext)
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
