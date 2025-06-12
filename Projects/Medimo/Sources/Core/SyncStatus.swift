//
//  SyncStatus.swift
//  Medimo
//
//  Created by 김현기 on 6/9/25.
//

import CoreData
import SwiftUI

class SyncStatus: ObservableObject {
    @Published var isSyncing: Bool = false

    private var observer: NSObjectProtocol?

    init() {
        observer = NotificationCenter.default.addObserver(
            forName: NSPersistentCloudKitContainer.eventChangedNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            if let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event {
                switch event.type {
                case .import, .export:
                    self?.isSyncing = (event.endDate == nil)
                default:
                    break
                }
            }
        }
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
