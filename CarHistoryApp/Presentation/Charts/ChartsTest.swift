//
//  ChartsTest.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/30/24.
//

import Foundation

struct LogTest: Identifiable {
  let id = UUID()
  let date: String
  let value: Int
  let type: LogTestType
  
  init() {
    self.date = TestDummy.randomDate()
    self.value = Int.random(in: 10...99) * 1000
    self.type = LogTestType.random()
  }
}

enum LogTestType: String, CaseIterable {
  case refuel = "주유"
  case repair = "정비"
  
  static func random() -> LogTestType {
    .allCases.randomElement()!
  }
}

enum TestDummy {
  static let mockData = [
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
    LogTest(), LogTest(), LogTest(), LogTest(), LogTest(), LogTest(),
  ]
  
  static func randomDate() -> String {
    let calendar = Calendar.current
    let today = Date()
    
    guard let sixMonthsAgo = calendar.date(byAdding: .month, value: -6, to: today) else {
      fatalError("Failed to calculate date 6 months ago.")
    }
    
    let daysBetween = calendar.dateComponents([.day], from: sixMonthsAgo, to: today).day ?? 0
    let randomDays = Int.random(in: 0...daysBetween)
    
    // 랜덤 날짜 생성
    guard let randomDate = calendar.date(byAdding: .day, value: randomDays, to: sixMonthsAgo) else {
      fatalError("Failed to calculate random date.")
    }
    
    // 랜덤 날짜를 "yy-MM" 형식으로 포매팅
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM" // "yy-MM" 형식 설정
    return dateFormatter.string(from: randomDate)
    
  }
}

