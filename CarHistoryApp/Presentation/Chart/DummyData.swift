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
    
    static let summary = [
        MonthlySummary(month: "2024-01", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-02", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 0, totalRefuelAmount: 30),
        MonthlySummary(month: "2024-03", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-04", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-05", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 22),
        MonthlySummary(month: "2024-06", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 0, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-07", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-08", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 55),
        MonthlySummary(month: "2024-09", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 0, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-10", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 50),
        MonthlySummary(month: "2024-11", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 500000, totalRefuelAmount: 40),
        MonthlySummary(month: "2024-12", fuelCost: Double.random(in: 10...100) * 1000.0, repairCost: 0, totalRefuelAmount: 10)
    ]
    
    static let mileage = [
        Mileage(mileage: 12300, date: Calendar.current.date(byAdding: .month, value: -12, to: Date())!),
        Mileage(mileage: 12500, date: Calendar.current.date(byAdding: .month, value: -11, to: Date())!),
        Mileage(mileage: 13000, date: Calendar.current.date(byAdding: .month, value: -10, to: Date())!),
        Mileage(mileage: 13300, date: Calendar.current.date(byAdding: .month, value: -9, to: Date())!),
        Mileage(mileage: 14300, date: Calendar.current.date(byAdding: .month, value: -8, to: Date())!),
        Mileage(mileage: 14700, date: Calendar.current.date(byAdding: .month, value: -7, to: Date())!),
        Mileage(mileage: 15000, date: Calendar.current.date(byAdding: .month, value: -6, to: Date())!),
        Mileage(mileage: 15300, date: Calendar.current.date(byAdding: .month, value: -5, to: Date())!),
        Mileage(mileage: 15700, date: Calendar.current.date(byAdding: .month, value: -4, to: Date())!),
        Mileage(mileage: 16000, date: Calendar.current.date(byAdding: .month, value: -3, to: Date())!),
        Mileage(mileage: 16300, date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        Mileage(mileage: 16700, date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!),
        Mileage(mileage: 17000, date: Date()),
    ]
    
    static let fuelAmount = [
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -12, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -11, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -10, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -9, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -8, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -7, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -6, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -5, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -4, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -3, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!),
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: 0, to: Date())!)
    ]
    
    static let repairCost = [
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -12, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -11, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -10, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -9, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -8, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -7, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -6, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -5, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -4, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -3, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!),
        RepairCost(cost: Double.random(in: 50000...1000000), date: Calendar.current.date(byAdding: .month, value: 0, to: Date())!)
    ]
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
