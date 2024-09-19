//
//  Car.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/17/24.
//

import Foundation
import RealmSwift
import CoreLocation

final class CarHistory: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date = Date()
    @Persisted var historyType = HistoryType.refuel
    @Persisted var content = ""
    @Persisted var mileage = 0.0
    @Persisted var latitude = 0.0
    @Persisted var longitude = 0.0
    @Persisted var cost = 0.0
    @Persisted var price = 0.0
    
    @Persisted(originProperty: "history") var group: LinkingObjects<Car>
    
    
    var toCLLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

final class Car: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var manufacturer = ""
    @Persisted var name = ""
    @Persisted var plateNumber = ""
    @Persisted var fuelType = FuelType.gasoline
    @Persisted var color = "" // 나중에
    
    @Persisted var historyList = RealmSwift.List<CarHistory>()
    
    
}

enum HistoryType: String, PersistableEnum, CaseIterable {
    case refuel = "Refuel"
    case maintenance = "Maint."
    case carWash = "Car Wash"
    case etc = "etc"
}

enum FuelType: String, PersistableEnum, CaseIterable {
    case gasoline = "Gasoline"
    case diesel = "Diesel"
    case electric = "Electric"
    case hydrogen = "Hydrogen"
}
 
