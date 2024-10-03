//
//  MonthlySummary.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/19/24.
//

import SwiftUI

enum MonthlySummary: CaseIterable, Hashable {
    
//    case mileage = "주행거리"
    case fuelCost(cost: String?)
    case carWash(date: String?)
    
    var value: String {
        switch self {
//        case .mileage:
//            "1,123 km"
        case .fuelCost:
            "₩ 120,000"
        case .carWash:
            "9월 10일"
        }
    }
    
    var image: String {
        switch self {
//        case .mileage:
//            "road.lanes"
        case .fuelCost:
            "fuelpump.fill"
        case .carWash:
            "bubbles.and.sparkles"
        }
    }
    
    static var allCases: [MonthlySummary] = [
        .fuelCost(cost: "₩ 0"),  // 기본 연관 값을 넣음
        .carWash(date: "기록없음")
    ]
}
