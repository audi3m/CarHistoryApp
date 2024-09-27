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
    static let recent = [
        RecentHistory(type: "정비", description: "블루핸즈", subDesc: "엔진오일 교체", color: .green, date: "8월 10일", image: "wrench.and.screwdriver"),
        RecentHistory(type: "주유", description: "GS칼텍스 꽃마을주유소", subDesc: "₩80,000 · 40L", color: .red, date: "9월 10일", image: "fuelpump.fill"),
        RecentHistory(type: "세차", description: "GS칼텍스 꽃마을주유소", subDesc: "5,000원", color: .blue, date: "9월 10일", image: "bubbles.and.sparkles"),
        RecentHistory(type: "주유", description: "HD현대오일뱅크 동작주유소", subDesc: "₩100,000 · 50L", color: .red, date: "9월 18일", image: "fuelpump.fill"),
        RecentHistory(type: "주유", description: "HD현대오일뱅크 동작주유소", subDesc: "110,000원 · 60L", color: .red, date: "9월 23일", image: "fuelpump.fill"),
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
        FuelCharge(amount: Double.random(in: 50000...120000), date: Calendar.current.date(byAdding: .month, value: -1, to: Date())!)
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
