//
//  Nearby.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/18/24.
//

import SwiftUI

enum Nearby: String, CaseIterable {
    case gasStation = "주유소"
    case repairShop = "정비소"
    case carWash = "세차장"
    
    var color: Color {
        switch self {
        case .gasStation:
            return Color.red.opacity(0.2)
        case .repairShop:
            return Color.green.opacity(0.2)
        case .carWash:
            return Color.blue.opacity(0.2)
        }
    }
    
    var image: String {
        switch self {
        case .gasStation:
            return "fuelpump.fill"
        case .repairShop:
            return "wrench.and.screwdriver"
        case .carWash:
            return "bubbles.and.sparkles"
        }
    }
}
