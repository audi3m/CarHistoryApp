//
//  LogChartViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import Foundation

final class LogChartViewModel: ObservableObject {
    
    private let dataManager: LocalDataManager
    
    @Published var category = Category.all
    @Published var summaryList = [MonthlySummary]()
    
    var filteredData: [BarData] {
        summaryList.map { summary in
            switch category {
            case .all:
                return BarData(month: summary.month, value: summary.fuelCost + summary.repairCost + summary.fuelAmount)
            case .fuelCost:
                return BarData(month: summary.month, value: summary.fuelCost)
            case .repair:
                return BarData(month: summary.month, value: summary.repairCost)
            case .fuelAmount:
                return BarData(month: summary.month, value: summary.fuelAmount)
            }
        }
    }
    
    init(dataManager: LocalDataManager) {
        print("init LogChartViewModel")
        self.dataManager = dataManager
        summaryList = aggregateDataByMonth(logs: dataManager.logs)
    }
    
    deinit {
        print("deinit LogChartViewModel")
    }
    
}

extension LogChartViewModel {
    
    func aggregateDataByMonth(logs: [LogDomain]) -> [MonthlySummary] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM"

        let groupedLogs = Dictionary(grouping: logs) { formatter.string(from: $0.date) }

        return groupedLogs.map { (month, logs) in
            let fuelCost = logs
                .filter { $0.logType == .refuel }
                .reduce(0) { $0 + $1.totalCost }

            let repairCost = logs
                .filter { $0.logType == .maintenance }
                .reduce(0) { $0 + $1.totalCost }

//            let totalMileage = logs.reduce(0) { $0 + $1.mileage }
            
            let totalRefuelAmount = logs
                .filter { $0.logType == .refuel }
                .reduce(0) { $0 + $1.refuelAmount }

            return MonthlySummary(
                month: month,
                fuelCost: fuelCost,
                repairCost: repairCost,
//                totalMileage: totalMileage,
                fuelAmount: totalRefuelAmount
            )
        }
        .sorted { $0.month < $1.month }
    }

}

struct MonthlySummary: Identifiable {
    let id = UUID()
    let month: String
    let fuelCost: Double
    let repairCost: Double
//    let totalMileage: Int
    let fuelAmount: Double
}

struct BarData: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
}

enum Category: String, CaseIterable {
    case all = "전체"
//    case mileage = "키로수"
    case fuelCost = "주유 비용"
    case repair = "정비 비용"
    case fuelAmount = "주유량"
}
