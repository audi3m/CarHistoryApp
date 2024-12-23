//
//  LogDomain.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import SwiftUI

struct LogDomain: Identifiable, Hashable {
    var id = UUID().uuidString
    var date = Date()
    var logType = LogTypeDomain.refuel
    var companyName = ""
    var mileage = 0
    var totalCost = 0.0
    var refuelAmount = 0.0
    var notes = ""
    var latitude = 0.0
    var longitude = 0.0
    
    init(id: String = UUID().uuidString, date: Date = Date(), logType: LogTypeDomain = LogTypeDomain.refuel, companyName: String = "", mileage: Int = 0, totalCost: Double = 0.0, refuelAmount: Double = 0.0, notes: String = "", latitude: Double = 0.0, longitude: Double = 0.0) {
        self.id = id
        self.date = date
        self.logType = logType
        self.companyName = companyName
        self.mileage = mileage
        self.totalCost = totalCost
        self.refuelAmount = refuelAmount
        self.notes = notes
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

extension LogDomain {
    func toDTO() -> CarLog {
        let dto = CarLog(date: date,
                         logType: logType.toDTO(),
                         companyName: companyName,
                         mileage: mileage,
                         totalCost: totalCost,
                         refuelAmount: refuelAmount,
                         notes: notes,
                         latitude: latitude,
                         longitude: longitude)
        return dto
    }
    
    static func randomLog() -> LogDomain {
        let log = LogDomain(date: DummyData.randomDate(),
                            logType: LogTypeDomain.allCases.randomElement()!,
                            mileage: 50000,
                            totalCost: Double.random(in: 10000...500000),
                            refuelAmount: Double.random(in: 20...55))
        return log
    }
}

extension LogDomain {
    var typeColor: Color {
        switch logType {
        case .refuel:
            return .red
        case .maintenance:
            return .green
        case .carWash:
            return .blue
        case .etc:
            return .brown
        }
    }
    
    var subDescription: String {
        return "₩" + "\(totalCost.formatted()) · \(refuelAmount.formatted())L"
    }
}

enum LogTypeDomain: String, CaseIterable {
    case refuel = "주유/충전"
    case maintenance = "정비"
    case carWash = "세차"
    case etc = "기타"
    
    func toDTO() -> LogType {
        switch self {
        case .refuel:
            return .refuel
        case .maintenance:
            return .maintenance
        case .carWash:
            return .carWash
        case .etc:
            return .etc
        }
    }
    
    var color: Color {
        switch self {
        case .refuel:
            return .red
        case .maintenance:
            return .green
        case .carWash:
            return .blue
        case .etc:
            return .brown
        }
    }
    
    var image: String {
        switch self {
        case .refuel:
            return "fuelpump"
        case .maintenance:
            return "wrench.and.screwdriver"
        case .carWash:
            return "bubbles.and.sparkles"
        case .etc:
            return "ellipsis.circle"
        }
    }
}
