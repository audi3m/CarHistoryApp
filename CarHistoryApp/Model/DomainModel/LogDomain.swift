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
    var logType = LogType.refuel
    var companyName = ""
    var mileage = 0
    var totalCost = 0.0
    var refuelAmount = 0.0
    var notes = ""
    var latitude = 0.0
    var longitude = 0.0
    
    init(id: String = UUID().uuidString, date: Date = Date(), logType: LogType = LogType.refuel, companyName: String = "", mileage: Int = 0, totalCost: Double = 0.0, refuelAmount: Double = 0.0, notes: String = "", latitude: Double = 0.0, longitude: Double = 0.0) {
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
                         logType: logType,
                         companyName: companyName,
                         mileage: mileage,
                         totalCost: totalCost,
                         refuelAmount: refuelAmount,
                         notes: notes,
                         latitude: latitude,
                         longitude: longitude)
        return dto
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
        switch logType {
        case .refuel:
            CurrencyInfo().symbol + "\(totalCost.formatted()) · \(refuelAmount.formatted())L"
        case .carWash:
            CurrencyInfo().symbol + "\(totalCost.formatted())"
        default:
            CurrencyInfo().symbol + "\(totalCost.formatted()) · \(notes)"
        }
    }
}
