//
//  StudyCalendarCardView.swift
//  Projects
//
//  Created by 양시준 on 6/5/25.
//

import CoreData
import SwiftUI

struct StudyCalendarCardView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(AppColor.white.opacity(0.9))
                .shadow(
                    color: Color(AppColor.skyBlue)
                        .opacity(0.45),
                    radius: 10, x: 0, y: 2
                )
            VStack {
                HStack {
                    Text("나의 학습 캘린더")
                        .font(.body)
                        .foregroundColor(AppColor.label)
                    Spacer()
                    Image("chevron-right")
                        .resizable()
                        .frame(width: 21, height: 21)
                        .foregroundColor(AppColor.skyBlue)
                }
                .padding(.bottom, 30)

                WeekdayHeaderView(isPreview: true)

                PreviewDatesGridView(calendarViewModel: calendarViewModel)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 26)
        }
    }
}

struct PreviewDatesGridView: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var calendarViewModel: CalendarViewModel

    var dateInfos: [DateInfo] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? moc.fetch(fetchRequest)) ?? []

        if let user = users.first {
            let array = user.dateInfos!.allObjects as? [DateInfo] ?? []
            return array
        }
        return []
    }

    @ViewBuilder
    private func studiedBackground(for dateValue: DateValue) -> some View {
        // dateInfo 중 해당 날짜와 같은 것이 있는지 찾기
        if let dateInfo = dateInfos.first(where: { calendarViewModel.isSameDay(date1: $0.date ?? Date(), date2: dateValue.date) }) {
            // 둘 다 0이 아니면 파란색, 하나만 0이 아니면 하늘색
            let bothNonZero = (dateInfo.studyCount > 0) && (dateInfo.reviewCount > 0)
            let onlyOneNonZero = (dateInfo.studyCount > 0) != (dateInfo.reviewCount > 0)
            let color = bothNonZero ? AppColor.blue : (onlyOneNonZero ? AppColor.skyBlue : nil)
            if let color = color {
                Circle()
                    .fill(color)
                    .frame(width: 32, height: 32)
            } else {
                Color.clear
            }
        }
    }

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    private func isSelected(value: DateValue) -> Bool {
        calendarViewModel.isSameDay(date1: value.date, date2: calendarViewModel.selectedDate)
    }

    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(calendarViewModel.extractCurrentWeekDateValues(currentMonth: calendarViewModel.currentMonth)
            ) { dateValue in
                if dateValue.day != -1 {
                    ZStack(alignment: .top) {
                        //                if isSelected {
                        //                    Circle()
                        //                        .foregroundStyle(AppColor.label)
                        //                        .frame(width: 6, height: 6)
                        //                        .offset(y: -10) // Adjust as needed to position above the text
                        //                }

                        Text("\(dateValue.day)")
                            .font(.bodyEng)
                            .foregroundStyle(isSelected(value: dateValue) ? AppColor.pink : AppColor.grey5)
                    }
                    .frame(height: 20)
                    .background(
                        studiedBackground(for: dateValue)
                    )

                } else {
                    Text("\(dateValue.day)").hidden()
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        StudyCalendarCardView(calendarViewModel: CalendarViewModel())
    }
}
