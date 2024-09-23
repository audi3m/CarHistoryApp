//
//  Nearby.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/18/24.
//

import SwiftUI

enum Nearby: String, CaseIterable {
    case parking = "Parking"
    case gasStation = "Gas & Ev"
//    case evCharge = "EV 충전소"
    case repairShop = "Repair"
    case carWash = "Wash"
    
    var color: Color {
        switch self {
        case .parking:
            return Color.brown.opacity(0.25)
        case .gasStation:
            return Color.red.opacity(0.25)
//        case .evCharge:
//            return Color.yellow.opacity(0.25)
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
//        case .evCharge:
//            return "ev.charger.fill"
        case .repairShop:
            return "wrench.and.screwdriver"
        case .carWash:
            return "bubbles.and.sparkles"
        }
    }
}
