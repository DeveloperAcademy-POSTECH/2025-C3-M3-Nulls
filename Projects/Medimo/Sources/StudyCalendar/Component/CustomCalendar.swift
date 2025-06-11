//
//  CustomCalendar.swift
//  Medimo
//
//  Created by 김현기 on 6/6/25.
//

import CoreData
import SwiftUI

struct CustomCalendar: View {
    @ObservedObject var calendarViewModel: CalendarViewModel

    var body: some View {
        VStack {
            YearMonthHeaderView(calendarViewModel: calendarViewModel)

            WeekdayHeaderView()
            DatesGridView(calendarViewModel: calendarViewModel)
        }
        .padding(.horizontal, 32)
    }
}

struct YearMonthHeaderView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel

    var body: some View {
        HStack {
            Text("\(String(calendarViewModel.selectedYear))년 \(calendarViewModel.selectedMonth)월")
                .font(.subheadline)
                .foregroundStyle(AppColor.label)
            Spacer()
            HStack {
                Button {
                    // 이전 달로 이동
                    calendarViewModel.currentMonth -= 1
                    calendarViewModel.selectedMonth -= 1
                    if calendarViewModel.selectedMonth < 1 {
                        calendarViewModel.selectedMonth = 12
                        calendarViewModel.selectedYear -= 1
                    }
                } label: {
                    Image("chevron-left")
                }

                Spacer().frame(width: 10)

                Button {
                    // 다음 달로 이동
                    calendarViewModel.currentMonth += 1
                    calendarViewModel.selectedMonth += 1
                    if calendarViewModel.selectedMonth > 12 {
                        calendarViewModel.selectedMonth = 1
                        calendarViewModel.selectedYear += 1
                    }
                } label: {
                    Image("chevron-right")
                }
            }
            .font(.system(size: 20))
        }
        .padding(.bottom, 16)
    }
}

struct WeekdayHeaderView: View {
    let isPreview: Bool = false
    private var weekdays: [String] = []

    init(isPreview: Bool = false) {
        if isPreview {
            weekdays = ["S", "M", "T", "W", "T", "F", "S"]
        } else {
            weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
        }
    }

    var body: some View {
        HStack {
            ForEach(weekdays, id: \.self) { weekday in
                Text(weekday)
                    .font(.custom("Gmarket Sans Medium", size: 12))
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(AppColor.grey3)
            }
        }
        .padding(.bottom, 16)
    }
}

struct DatesGridView: View {
    @ObservedObject var calendarViewModel: CalendarViewModel

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(calendarViewModel.extractDateToDateValueArray(currentMonth: calendarViewModel.currentMonth)
            ) { dateValue in
                if dateValue.day != -1 {
                    DateButton(
                        calendarViewModel: calendarViewModel,
                        value: dateValue
                    )
                } else {
                    Text("\(dateValue.day)").hidden()
                }
            }
        }
    }
}

struct DateButton: View {
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var calendarViewModel: CalendarViewModel

    var value: DateValue

    private var isToday: Bool {
        Calendar.current.isDateInToday(value.date)
    }

    private var isSelected: Bool {
        calendarViewModel.isSameDay(date1: value.date, date2: calendarViewModel.selectedDate)
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

    var body: some View {
        Button {
            calendarViewModel.selectedDate = value.date
            print("📝 Selected Day: \(value.day)")
        } label: {
            ZStack(alignment: .top) {
                Text("\(value.day)")
                    .font(.bodyEng)
                    .foregroundStyle(value.date > Date() ? AppColor.grey2 : isSelected ? AppColor.pink : AppColor.grey5)
            }
            .frame(height: 20)
            .background(
                studiedBackground(for: value)
            )
        }
        .disabled(value.date > Date() ? true : false)
    }
}

#Preview {
    CustomCalendar(calendarViewModel: CalendarViewModel())
}
