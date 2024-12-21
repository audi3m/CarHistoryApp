//
//  NearbyEnum.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/18/24.
//

import SwiftUI

enum NearbyEnum: String, CaseIterable {
    case parking = "주차장"
    case gasStation = "주유/충전"
    //    case evCharge = "EV 충전소"
    case repairShop = "정비소"
    case carWash = "세차장"
    
}

extension NearbyEnum {
    
    var color: Color {
        switch self {
        case .parking:
            return .brown
        case .gasStation:
            return .red
//        case .evCharge:
//            return Color.yellow.opacity(0.25)
        case .repairShop:
            return .greenText
        case .carWash:
            return .blueText
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
    
    var query: String {
        switch self {
        case .parking:
            "주차장"
        case .gasStation:
            "주유소"
        case .repairShop:
            "정비소"
        case .carWash:
            "세차장"
        }
    }
}
