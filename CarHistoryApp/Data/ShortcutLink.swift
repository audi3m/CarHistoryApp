//
//  ShortcutLink.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/18/24.
//

import SwiftUI

enum ShortcutLink: String, CaseIterable {
    case graph = "통계"
    case scooter = "스쿠터"
    case bus = "버스"
    case hotel = "호텔"
    
    var image: String {
        switch self {
        case .graph: "chart.bar.xaxis"
        case .scooter: "scooter"
        case .bus: "bus.fill"
        case .hotel: "building.2.fill"
        }
    }
}
