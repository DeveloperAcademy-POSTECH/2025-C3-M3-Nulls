//
//  Date+Extension.swift
//  Projects
//
//  Created by 김현기 on 6/6/25.
//

import Foundation

extension Date {
    // 현재 월의 날짜를 Date 배열로 만들어주는 함수
    func getAllDates() -> [Date] {
        let calendar = Calendar.current

        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!

        let range = calendar.range(of: .day, in: .month, for: startDate)!

        return range.compactMap { day -> Date in
            calendar.date(
                byAdding: .day,
                value: day - 1, // range는 1부터 시작하므로 -1을 해줌
                to: startDate
            ) ?? Date()
        }
    }
}
