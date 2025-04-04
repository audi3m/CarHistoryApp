//
//  Car.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/17/24.
//

import Foundation
import RealmSwift

final class Car: Object, ObjectKeyIdentifiable {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var manufacturer = ""
  @Persisted var name = ""
  @Persisted var plateNumber = ""
  @Persisted var fuelType = FuelType.gasoline
  @Persisted var color = ""
  
  @Persisted var logList: List<CarLog>
  
  convenience init(manufacturer: String = "",
                   name: String = "",
                   plateNumber: String = "",
                   fuelType: FuelType = FuelType.gasoline,
                   color: String = "") {
    self.init()
    self.manufacturer = manufacturer
    self.name = name
    self.plateNumber = plateNumber
    self.fuelType = fuelType
    self.color = color
  }
}

extension Car {
  func toDomain() -> CarDomain {
    let car = CarDomain(id: id.stringValue,
                        manufacturer: manufacturer,
                        name: name,
                        plateNumber: plateNumber,
                        fuelTypeDomain: fuelType.toDomain(),
                        color: color)
    return car
  }
}

enum FuelType: String, PersistableEnum, CaseIterable {
  case gasoline = "휘발유 / 경유"
  case electric = "전기"
  case hydrogen = "수소"
  
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

extension FuelType {
  func toDomain() -> FuelTypeDomain {
    switch self {
    case .gasoline:
      return .gasoline
    case .electric:
      return .electric
    case .hydrogen:
      return .hydrogen
    }
  }
}

