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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CustomCalendar(calendarViewModel: CalendarViewModel())
}
