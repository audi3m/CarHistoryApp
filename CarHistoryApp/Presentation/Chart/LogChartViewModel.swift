//
//  LogChartViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import Foundation

final class LogChartViewModel: ObservableObject {
    
    @Published var monthlySummary = [MonthlySummary]()
    
    
    
    
    init() {
        print("init LogChartViewModel")
        monthlySummary = aggregateDataByMonth(logs: [])
    }
    
    deinit {
        print("deinit LogChartViewModel")
    }
    
}

extension LogChartViewModel {
    
    func aggregateDataByMonth(logs: [LogDomain]) -> [MonthlySummary] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"

        let groupedLogs = Dictionary(grouping: logs) { log in
            dateFormatter.string(from: log.date)
        }

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
                totalRefuelAmount: totalRefuelAmount
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
    let totalRefuelAmount: Double
}
