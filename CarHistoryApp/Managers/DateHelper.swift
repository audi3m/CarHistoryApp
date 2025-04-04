//
//  DateHelper.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

struct DateHelper {
  
  static var formatter = DateFormatter()
  
  static func currentMonthLong() -> String {
    formatter.locale = Locale.init(identifier: "ko_kr")
    formatter.dateFormat = "MMMM"
    return formatter.string(from: Date())
  }
  
  // Sep 30, 2024
  static func shortFormat(date: Date) -> String {
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
}

extension Date {
  func toSep30() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter.string(from: self)
  }
}
