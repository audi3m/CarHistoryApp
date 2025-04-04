//
//  DummyData.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/17/24.
//

import SwiftUI

struct RecentHistory: Identifiable {
  let id = UUID()
  let type: String
  var description = ""
  var subDesc = ""
  let color: Color
  let date: String
  let image: String
}

enum DummyData {
  
  static let logSample: [LogDomain] = [
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
    LogDomain.randomLog(),
  ]
  
  static func randomDate() -> Date {
    let calendar = Calendar.current
    let now = Date()
    
    guard let fiveMonthsAgo = calendar.date(byAdding: .month, value: -6, to: now) else {
      fatalError("Cannot calculate the date 5 months ago")
    }
    
    let timeIntervalSinceFiveMonthsAgo = now.timeIntervalSince(fiveMonthsAgo)
    let randomTimeInterval = TimeInterval.random(in: 0...timeIntervalSinceFiveMonthsAgo)
    let randomDate = fiveMonthsAgo.addingTimeInterval(randomTimeInterval)
    
    return randomDate
  }
}

struct Mileage: Identifiable {
  let id = UUID()
  let mileage: Double
  let date: Date
}

struct FuelCharge: Identifiable {
  let id = UUID()
  let amount: Double
  let date: Date
}

struct RepairCost: Identifiable {
  let id = UUID()
  let cost: Double
  let date: Date
}
