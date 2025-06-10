//
//  StudyView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI
import CoreData

struct StudyView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @State var studyManager: StudyManager = .shared
    @StateObject var calendarViewModel = CalendarViewModel()
    @State var studyViewModel: StudyViewModel
    
    @State private var isAtTop: Bool = true
    @Binding var isStudyInProgress: Bool

    init(context: NSManagedObjectContext, isStudyInProgress: Binding<Bool>) {
        studyViewModel = .init(moc: context)
        _isStudyInProgress = isStudyInProgress
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    StudyHeaderView(streak: studyViewModel.streak)

                    StudyMainCardView(isStudyInProgress: $isStudyInProgress)
                        .padding(.top, 42)
                        .padding(.horizontal, 16)

                    StudyCalendarCardView(calendarViewModel: calendarViewModel)
                        .onTapGesture {
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

private struct StudyViewPreviewWrapper: View {
    @State var isStudyInProgress = false

    var body: some View {
        let context = CoreDataManager.preview.container.viewContext
        StudyManager.shared.setContext(context)

        return StudyView(context: context, isStudyInProgress: $isStudyInProgress)
            .environmentObject(NavigationManager())
            .environment(\.managedObjectContext, context)
    }
}

#Preview {
    StudyViewPreviewWrapper()
}
