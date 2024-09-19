//
//  MonthlySummary.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/19/24.
//

import Foundation

enum MonthlySummary: String, CaseIterable {
    case mileage = "km"
    case fuelCost = "주유금액"
    case carWash = "마지막세차"
    
    var value: String {
        switch self {
        case .mileage:
            "12,123"
        case .fuelCost:
            "120,000원"
        case .carWash:
            "9월 10일"
        }
    }
}
