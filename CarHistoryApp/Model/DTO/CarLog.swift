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
    
    convenience init(date: Date = Date(),
                     logType: LogType = LogType.refuel,
                     companyName: String = "",
                     mileage: Int = 0,
                     totalCost: Double = 0.0,
                     refuelAmount: Double = 0.0,
                     notes: String = "",
                     latitude: Double = 0.0,
                     longitude: Double = 0.0) {
        self.init()
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

extension CarLog {
    func toDomain() -> LogDomain {
        let log = LogDomain(id: id.stringValue,
                            date: date,
                            logType: logType,
                            companyName: companyName,
                            mileage: mileage,
                            totalCost: totalCost,
                            refuelAmount: refuelAmount,
                            notes: notes,
                            latitude: latitude,
                            longitude: longitude)
        return log
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


