//
//  LogChartViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import Foundation

final class LogChartViewModel: ObservableObject {
  
  private let dataManager: LocalDataManager
  
  //    @Published var logsForBarChart: [BarChartData] = []
  
  @Published var category = Category.all
  @Published var month = Month.six
  
  var filteredData: [LogDomain] {
    switch category {
    case .all:
      return dataManager.logs
    case .fuelCost:
      return dataManager.logs.filter { $0.logType == .refuel }
    case .repair:
      return dataManager.logs.filter { $0.logType == .maintenance }
    case .fuelAmount:
      return []
    }
  }
  
  init(dataManager: LocalDataManager) {
    print("init LogChartViewModel")
    self.dataManager = dataManager
  }
  
  deinit {
    print("deinit LogChartViewModel")
  }
  
}

extension LogChartViewModel {
  
  private func setBarData() -> [BarData] {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM"
    
    var barDataList = [BarData]()
    
    let today = Date()
    var months: [String] = []
    
    for i in 0..<12 {
      if let date = calendar.date(byAdding: .month, value: -i, to: today) {
        let month = dateFormatter.string(from: date)
        months.append(month)
      }
    }
    
    for month in months.reversed() {
      barDataList.append(BarData(month: month))
    }
    
    return barDataList
  }
  
  private func setChartData(logs: [LogDomain]) -> [BarData] {
    var barDataList = setBarData()
    
    for log in logs {
      
    }
    
    return []
  }
  
}

extension LogChartViewModel {
  
}

enum Category: String, CaseIterable {
  case all = "전체"
  //    case mileage = "키로수"
  case fuelCost = "주유 비용"
  case repair = "정비 비용"
  case fuelAmount = "주유량"
}

enum Month: CaseIterable {
  case three
  case six
  case twelve
}

// 구조체
struct BarData: Identifiable {
  let id = UUID()
  let month: String
  var repairCost = 0.0
  var refuelCost = 0.0
}
