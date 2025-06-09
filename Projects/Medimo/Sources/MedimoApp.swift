import SwiftUI

@main
struct MedimoApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView(context: coreDataManager.context)
                .environment(\.managedObjectContext,
                             coreDataManager.context)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}
