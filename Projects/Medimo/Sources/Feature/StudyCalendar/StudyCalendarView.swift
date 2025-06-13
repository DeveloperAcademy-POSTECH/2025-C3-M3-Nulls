//
//  StudyCalendarView.swift
//  Medimo
//
//  Created by 김현기 on 6/6/25.
//

import CoreData
import SwiftUI

struct StudyCalendarView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var navigationManager: NavigationManager

    @StateObject private var calendarViewModel = CalendarViewModel()
    let coreDataManager = CoreDataManager.shared
    let cloudKitManager = CloudKitManager.shared

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? moc.fetch(fetchRequest)) ?? []

        return users.first ?? User(context: moc)
    }

    var dateInfos: [DateInfo] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? moc.fetch(fetchRequest)) ?? []

        if let user = users.first {
            let array = user.dateInfos!.allObjects as? [DateInfo] ?? []
            return array
        }
        return []
    }

    func getTotalStudyCount() -> Int {
        Int(dateInfos.first(where: {
            calendarViewModel.isSameDay(date1: $0.date ?? Date(), date2: calendarViewModel.selectedDate)
        })?.studyCount ?? 0)
    }

    func getTotalReviewCount() -> Int {
        Int(dateInfos.first(where: {
            calendarViewModel.isSameDay(date1: $0.date ?? Date(), date2: calendarViewModel.selectedDate)
        })?.reviewCount ?? 0)
    }

    var body: some View {
        ZStack {
            AppColor.bgColor
                .ignoresSafeArea(.all)

            VStack {
                Spacer()
                Image("cloudBottom")
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        if !navigationManager.studyPath.isEmpty {
                            navigationManager.studyPath.removeLast()
                        }
                    } label: {
                        Image("chevron-left")
                            .foregroundStyle(AppColor.blue)
                    }
                    Spacer()
                    Text("캘린더")
                        .foregroundStyle(AppColor.navy)
                        .font(.headline)
                    Spacer()
                    Button {} label: {
                        Image("download")
                            .foregroundStyle(AppColor.blue)
                    }
                    .opacity(0.0)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                ScrollView {
                    HStack {
                        Spacer()
                        VStack {
                            Text("\(getTotalStudyCount())개")
                                .font(.title)
                                .foregroundStyle(AppColor.navy)
                                .padding(.bottom, 15)
                            Text("외운 단어 수")
                                .font(.headline)
                                .foregroundStyle(AppColor.grey3)
                        }
                        Spacer(minLength: 75)
                        VStack {
                            Text("\(user.longestStreak)일")
                                .font(.title)
                                .foregroundStyle(AppColor.blue)
                                .padding(.bottom, 15)
                            Text("최대 연속 학습")
                                .font(.headline)
                                .foregroundStyle(AppColor.grey3)
                        }
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(AppColor.label)
                    .padding(.vertical, 32)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                    )
                    .padding(16)

                    // 달력
                    VStack {
                        CustomCalendar(calendarViewModel: calendarViewModel)
                        calendarSuccessCriteria()
                            .padding(.top, 16)
                    }
                    .padding(.vertical, 32)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 25)

                    // 단어 통계
                    VStack {
                        HStack {
                            Text(calendarViewModel.getSelectedDateString())
                                .font(.headline)
                                .foregroundStyle(AppColor.navy)

                            Spacer()
                        }
                        .padding(.horizontal, 16)

                        WordsStatisticsView(description: "학습한 단어", count: getTotalStudyCount())
                        Spacer().frame(height: 10)
                        WordsStatisticsView(description: "복습한 단어", count: getTotalReviewCount())
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 50)

                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct calendarSuccessCriteria: View {
    var body: some View {
        HStack {
            Circle()
                .fill(AppColor.skyBlue)
                .frame(width: 14, height: 14)
            Text("하나 성공!")
                .font(.subheadline)
                .foregroundStyle(AppColor.grey3)

            Spacer().frame(width: 42)

            Circle()
                .fill(AppColor.blue)
                .frame(width: 14, height: 14)
            Text("학습 달성!")
                .font(.subheadline)
                .foregroundStyle(AppColor.grey3)
        }
    }
}

struct WordsStatisticsView: View {
    let description: String
    let count: Int

    var body: some View {
        HStack {
            Text(description)
                .font(.caption)
                .foregroundStyle(AppColor.blue)

            Spacer()

            Text("\(count)개")
                .font(.bodyEng)
                .foregroundStyle(AppColor.navy)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
        )
    }
}

#Preview {
    StudyCalendarView()
        .environmentObject(NavigationManager())
}
