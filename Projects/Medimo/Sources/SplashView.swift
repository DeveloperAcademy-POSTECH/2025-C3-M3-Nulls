//
//  SplashView.swift
//  Medimo
//
//  Created by 김현기 on 6/5/25.
//

import CoreData
import SwiftUI

struct SplashView: View {
//    @Environment(\.managedObjectContext) private var context
    private let persistenceController = PersistenceController.shared

    init() {
//        if isFirstLaunch() {
//            let loader = InitialDataLoader(context: context)
//            do {
//                Task {
//                    try await loader.loadInitialData()
//                }
//
//                try context.save()
//                #if DEBUG
//                    print("Initial data loaded.")
//                #endif
//            } catch {
//                #if DEBUG
//                    print("Failed to load initial data: \(error)")
//                #endif
//            }
//        }
    }

    var body: some View {
        Image("LaunchScreen")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

extension SplashView {
//    private func isFirstLaunch() -> Bool {
//        // Term이 1개 이상 존재하는지 여부로 최초 실행 여부 판단
//        let fetchRequest: NSFetchRequest<Term> = Term.fetchRequest()
//        do {
//            let count = try context.count(for: fetchRequest)
//            print("✏️ CoreData<Term> Count: \(count)")
//            return count == 0
//        } catch {
//            print("✏️ Failed to fetch Term count: \(error)")
//            return true
//        }
//    }
}

#Preview {
    SplashView()
}
