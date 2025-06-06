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
    @Published var SelectedYear: Int = Calendar.current.component(.year, from: .now)
    @Published var SelectedMonth: Int = Calendar.current.component(.month, from: .now)
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

    // 두 날짜가 같은 날인지 확인하는 함수
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current

        return calendar.isDate(date1, inSameDayAs: date2)
    }

//    func extractDateToDateValueArray(currentMonth: Int) -> [DateValue] {
//        let calendar = Calendar.current
//
//        let presentedMonth = getCurrentMonth(addingMonth: currentMonth)
//
//
//    }
}
