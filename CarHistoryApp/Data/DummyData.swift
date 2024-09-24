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
        Mileage(mileage: 12300, date: 1),
        Mileage(mileage: 12500, date: 2),
        Mileage(mileage: 13000, date: 3),
        Mileage(mileage: 13300, date: 4),
        Mileage(mileage: 14300, date: 5),
        Mileage(mileage: 14700, date: 6),
    ]
}

struct Mileage: Identifiable {
    let id = UUID()
    let mileage: Double
    let date: Int
    
    var month: String {
        return "\(date)월)"
    }
}
