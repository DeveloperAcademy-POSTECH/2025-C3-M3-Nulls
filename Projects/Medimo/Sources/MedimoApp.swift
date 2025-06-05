import SwiftUI

@main
struct MedimoApp: App {
    let persistenceController = PersistenceController.shared
    let cloudKitManager = CloudKitManager.shared

    init() {
        cloudKitManager.checkiCloudAccountStatus { status in
            if status == .available {
                print("iCloud account is available.")
            } else {
                print("iCloud account is not available. Please check your iCloud settings.")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                             persistenceController.container.viewContext)
        }
    }
}
