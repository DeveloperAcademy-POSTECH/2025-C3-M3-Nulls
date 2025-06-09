//
//  NavigationManager.swift
//  Projects
//
//  Created by 김현기 on 6/2/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var glossaryPath: [PathType] = []
    @Published var studyPath: [PathType] = []
    @Published var reviewPath: [PathType] = []
    @Published var dictionaryPath: [PathType] = []

//    func push(to destination: PathType) {
//        path.append(destination)
//    }
//
//    func pop() {
//        if !path.isEmpty {
//            path.removeLast()
//        }
//    }
//
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
//
//    func setRootAndPush(to destination: PathType) {
//        path.removeLast(path.count)
//        path.append(destination)
//    }
}
