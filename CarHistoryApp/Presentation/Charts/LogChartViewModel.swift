//
//  LogChartViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import Foundation

final class LogChartViewModel: ObservableObject {
    
    private let dataManager: LocalDataManager
    
    @Published var logsForBarChart: [BarChartData] = []
    
    @Published var category = Category.all
    @Published var month = Month.six
    
    var newFilteredData: [LogDomain] {
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
    // 튜플
    static let tupleList = [("Jan", 1), ("Feb", 2), ("Mar", 3), ("Apr", 4), ("May", 5), ("Jun", 6),
                            ("Jul", 7), ("Aug", 8), ("Sep", 9), ("Oct", 10), ("Nov", 11), ("Dec", 12)]
    
    // 사전 - 순서
    static let dicList = ["Jan": 1, "Feb": 2, "Mar": 3, "Apr": 4, "May": 5, "Jun": 6,
                          "Jul": 7, "Aug": 8, "Sep": 9, "Oct": 10, "Nov": 11, "Dec": 12]
    
    // 구조체
    struct BarData: Identifiable {
        let id = UUID()
        let month: String
        var repairCost = Double.random(in: 100000...2000000)
        var refuelCost = Double.random(in: 10000...90000)
    }
    
    static let structList = [BarData(month: "Jan"), BarData(month: "Feb"), BarData(month: "Mar"),
                             BarData(month: "Apr"), BarData(month: "May"), BarData(month: "Jun"),
                             BarData(month: "Jul"), BarData(month: "Aug"), BarData(month: "Sep"),
                             BarData(month: "Oct"), BarData(month: "Nov"), BarData(month: "Dec")]
    
}

extension LogChartViewModel {
    func groupLogsByMonth(logs: [LogDomain]) -> [Int: [LogDomain]] {
        var groupedLogs: [Int: [LogDomain]] = [:]
        let calendar = Calendar.current

        for log in logs {
            let month = calendar.component(.month, from: log.date)

            if groupedLogs[month] != nil {
                groupedLogs[month]?.append(log)
            } else {
                groupedLogs[month] = [log]
            }
        }

        return groupedLogs
    }
}

struct BarChartData {
    let date: Date
    let logs: [LogDomain]
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
