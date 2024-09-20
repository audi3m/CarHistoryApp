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
    let color: Color
    let date: String
    let image: String
}

enum DummyData {
    static let recent = [
        RecentHistory(type: "정비", description: "엔진오일 교체", color: .green, date: "8월 10일", image: "wrench.and.screwdriver"),
        RecentHistory(type: "주유", color: .red, date: "9월 10일", image: "fuelpump.fill"),
        RecentHistory(type: "세차", color: .blue, date: "9월 10일", image: "bubbles.and.sparkles")
    ]
}
