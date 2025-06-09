import SwiftUI

@main
struct MedimoApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            Color(.blue)
//            ContentView(context: coreDataManager.context)
//                .environment(\.managedObjectContext,
//                             coreDataManager.context)
        }
    }
}
