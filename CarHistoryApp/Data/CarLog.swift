//
//  CarLog.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/27/24.
//

import SwiftUI
import RealmSwift
import CoreLocation

final class CarLog: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date = Date()
    @Persisted var logType = LogType.refuel
    @Persisted var companyName = ""
    @Persisted var mileage = 0
    @Persisted var totalCost = 0.0
    @Persisted var refuelAmount = 0.0
    @Persisted var notes = ""
    @Persisted var latitude = 0.0
    @Persisted var longitude = 0.0 
    
    @Persisted(originProperty: "logList") var car: LinkingObjects<Car>
}

extension CarLog {
    var toCLLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
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

enum LogType: String, PersistableEnum, CaseIterable {
    case refuel = "주유/충전"
    case maintenance = "정비"
    case carWash = "세차"
    case etc = "기타"
    
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


