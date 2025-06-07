//
//  StudyView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Bindable var studyManager: StudyManager = .shared
    @StateObject var calendarViewModel = CalendarViewModel()

//    @Bindable var viewModel: StudyViewModel
    
    // TODO: streak 처리
    var streak: Int = 0

    @State private var isAtTop: Bool = true

    init() {}

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    StudyHeaderView(streak: streak)
                    StudyMainCardView()
                    .padding(.top, 42)
                    .padding(.horizontal, 16)

                    StudyCalendarCardView(calendarViewModel: calendarViewModel)
                        .onTapGesture {
                            print("TAP")
                            navigationManager.studyPath.append(.StudyCalendar)
                        }
                        .padding(16)
                        .padding(.bottom, 84)
                }
                .background(
                    StudyHeaderBackgroundView()
                )
            }
            .scrollIndicators(.hidden)
            .ignoresSafeArea(edges: .top)
            .background(AppColor.systemGroupedBackground)
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    StudyManager.shared.setContext(context)

    return StudyView()
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
