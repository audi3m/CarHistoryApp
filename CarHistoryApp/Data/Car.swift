//
//  Car.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/17/24.
//

import SwiftUI
import RealmSwift

final class Car: Object, ObjectKeyIdentifiable, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var manufacturer = ""
    @Persisted var name = ""
    @Persisted var plateNumber = ""
    @Persisted var fuelType = FuelType.gasoline
    @Persisted var color = ""
    
    @Persisted var logList = RealmSwift.List<CarLog>()
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
 
