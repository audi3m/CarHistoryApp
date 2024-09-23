//
//  MonthlySummary.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/19/24.
//

import SwiftUI

enum MonthlySummary: String, CaseIterable {
    case mileage = "Mileage"
    case fuelCost = "Fuel Cost"
    case carWash = "Last wash"
    
    var value: String {
        switch self {
        case .mileage:
            "1,123 km"
        case .fuelCost:
            "₩ 120,000"
        case .carWash:
            "9월 10일"
        }
    }
    
    var image: String {
        switch self {
        case .mileage:
            "road.lanes"
        case .fuelCost:
            "fuelpump.fill"
        case .carWash:
            "bubbles.and.sparkles"
        }
    }
    
    @ViewBuilder
    var navigationLink: some View {
        switch self {
        case .mileage:
            MileageView()
        case .fuelCost:
            FuelCostView()
        case .carWash:
            MaintanenceView()
        }
    }
}
