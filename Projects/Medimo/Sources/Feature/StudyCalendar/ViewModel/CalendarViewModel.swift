//
//  CalendarViewModel.swift
//  Projects
//
//  Created by 김현기 on 6/6/25.
//

import SwiftUI

struct DateValue: Identifiable {
    var id: String = UUID().uuidString
    var day: Int
    var date: Date
}

class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date = .now
    @Published var currentMonth: Int = 0

    @Published var selectedDate: Date = .now
    @Published var selectedYear: Int = Calendar.current.component(.year, from: .now)
    @Published var selectedMonth: Int = Calendar.current.component(.month, from: .now)
}

extension CalendarViewModel {
    // ["2025", "6월"]과 같은 문자열을 반환하는 함수
    func getYearAndMonthString(currentDate: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        formatter.locale = Locale(identifier: "ko_KR")

        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }

    // 현재 날짜를 기준으로 특정 월을 더한 날짜를 반환하는 함수
    func getCurrentMonth(addingMonth: Int) -> Date {
        let calendar = Calendar.current

        guard let currentMonth = calendar.date(
            byAdding: .month,
            value: addingMonth,
            to: Date()
        ) else { return Date() }

        return currentMonth
    }

    func createNewDate() -> Date {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = 1

        guard let selectedDate = Calendar.current.date(from: components) else {
            return Date()
        }
        return selectedDate
    }

    // 두 날짜가 같은 날인지 확인하는 함수
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current

        return calendar.isDate(date1, inSameDayAs: date2)
    }

    // 해당 월의 모든 날짜들을 DateValue 배열로 만들어주는 함수,
    // 모든 날짜를 배열로 만들어야 Grid에서 보여주기 가능
    func extractDateToDateValueArray(currentMonth: Int) -> [DateValue] {
        let calendar = Calendar.current

        let presentedMonth: Date = getCurrentMonth(addingMonth: currentMonth)

        var days: [DateValue] = presentedMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)

            return DateValue(day: day, date: date)
        }

        // Int값. SUN: 1, MON: 2, ..., SAT: 7
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())

        for _ in 0 ..< firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }

        return days
    }

    // 현재 주의 날짜들을 DateValue 배열로 만들어주는 함수
    func extractCurrentWeekDateValues(currentMonth: Int) -> [DateValue] {
        let calendar = Calendar.current
        let presentedMonth: Date = getCurrentMonth(addingMonth: currentMonth)
        let days: [DateValue] = presentedMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }

        let weekDays = days.filter {
            calendar.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear)
        }

        return weekDays
    }
}

// MARK: - Custom Calender 제외

extension CalendarViewModel {
    func getSelectedDateString() -> String {
        let date = selectedDate
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        let formatted = formatter.string(from: date)

        return formatted
    }
}
