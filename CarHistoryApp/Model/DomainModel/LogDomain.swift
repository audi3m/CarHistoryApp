//
//  LogDomain.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation

struct LogDomain: Identifiable {
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
