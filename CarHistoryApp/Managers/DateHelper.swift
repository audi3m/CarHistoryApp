//
//  DateHelper.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

final class DateHelper {
    static let shared = DateHelper()
    private init() { }
    
    let formatter = DateFormatter()
    
    func currentMonthLong() -> String {
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
    }
    
    // Sep 30, 2024
    func shortFormat(date: Date) -> String {
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
}

extension Date {
    func toSep30() -> String {
        let date = DateFormatter()
        date.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMd", options: 0, locale: .autoupdatingCurrent)
        return date.string(from: self)
    }
}
