//
//  Date+Ex.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

final class DateHelper {
    static let shared = DateHelper()
    private init() { }
    
    let formatter = DateFormatter()
    
    func currentMonth() -> String {
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
    }
    
    func shortFormat(date: Date) -> String {
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    
    
}
