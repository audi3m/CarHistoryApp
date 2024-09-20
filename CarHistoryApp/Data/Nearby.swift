//
//  Nearby.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/18/24.
//

import SwiftUI

enum Nearby: String, CaseIterable {
    case parking = "주차장"
    case gasStation = "주유소"
    case repairShop = "정비소"
    case carWash = "세차장"
    
    var color: Color {
        switch self {
        case .parking:
            return Color.brown.opacity(0.25)
        case .gasStation:
            return Color.red.opacity(0.25)
        case .repairShop:
            return Color.green.opacity(0.25)
        case .carWash:
            return Color.blue.opacity(0.25)
        }
    }
    
    var image: String {
        switch self {
        case .parking:
            return "parkingsign"
        case .gasStation:
            return "fuelpump.fill"
        case .repairShop:
            return "wrench.and.screwdriver"
        case .carWash:
            return "bubbles.and.sparkles"
        }
    }
}
