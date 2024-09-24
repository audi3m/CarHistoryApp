//
//  Car.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/17/24.
//

import SwiftUI
import RealmSwift
import CoreLocation

final class Car: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var manufacturer = ""
    @Persisted var name = ""
    @Persisted var plateNumber = ""
    @Persisted var fuelType = FuelType.gasoline
    @Persisted var color = ""
    
    @Persisted var historyList = RealmSwift.List<CarHistory>()
}

final class CarHistory: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date = Date()
    @Persisted var historyType = HistoryType.refuel
    @Persisted var mileage = ""
    @Persisted var totalCost = ""
    @Persisted var price = ""
    @Persisted var refuelAmount = ""
    @Persisted var notes = ""
    @Persisted var latitude = 0.0
    @Persisted var longitude = 0.0
    @Persisted var car: Car?
    
    @Persisted(originProperty: "historyList") var owner: LinkingObjects<Car>
    
    var toCLLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

enum HistoryType: String, PersistableEnum, CaseIterable {
    case refuel = "Refuel"
    case maintenance = "Maintenance"
    case carWash = "Car Wash"
    case etc = "etc"
    
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

enum FuelType: String, PersistableEnum, CaseIterable {
    case gasoline = "Gasoline / Diesel"
    case electric = "Electric"
    case hydrogen = "Hydrogen"
    
    var image: String {
        switch self {
        case .gasoline:
            return "engine.combustion"
        case .electric:
            return "bolt.car"
        case .hydrogen:
            return "leaf"
        }
    }
}
 
