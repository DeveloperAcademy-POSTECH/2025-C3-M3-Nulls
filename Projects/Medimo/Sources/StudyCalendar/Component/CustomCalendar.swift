//
//  CustomCalendar.swift
//  Medimo
//
//  Created by 김현기 on 6/6/25.
//

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
                    .font(.captionEng)
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
    @ObservedObject var calendarViewModel: CalendarViewModel

    var value: DateValue

    private var isToday: Bool {
        Calendar.current.isDateInToday(value.date)
    }

    private var isSelected: Bool {
        calendarViewModel.isSameDay(date1: value.date, date2: calendarViewModel.selectedDate)
    }

    var body: some View {
        Button {
            calendarViewModel.selectedDate = value.date
            print("📝 Selected Day: \(value.day)")
        } label: {
            ZStack(alignment: .top) {
//                if isSelected {
//                    Circle()
//                        .foregroundStyle(AppColor.label)
//                        .frame(width: 6, height: 6)
//                        .offset(y: -10) // Adjust as needed to position above the text
//                }

                Text("\(value.day)")
                    .font(.bodyEng)
                    .foregroundStyle(isSelected ? AppColor.hotPink : AppColor.grey5)
            }
            .frame(height: 20)
            .background(
                // 1개 성공시
//                Circle()
//                    .fill(AppColor.skyBlue)
//                    .frame(width: 40, height: 40)
//                    .opacity(isSelected ? 1 : 0)

                // 2개 성공시
                Circle()
                    .fill(AppColor.blue)
                    .frame(width: 40, height: 40)
                    .opacity(isSelected ? 1 : 0)
            )
        }
//        .disabled(value.date > Date() ? true : false)
    }
}

#Preview {
    CustomCalendar(calendarViewModel: CalendarViewModel())
}
