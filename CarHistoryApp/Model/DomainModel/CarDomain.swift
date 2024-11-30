//
//  CarDomain.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation

struct CarDomain: Identifiable, Equatable, Hashable {
    var id = UUID().uuidString
    var manufacturer: String
    var name: String
    var plateNumber: String
    var fuelTypeDomain: FuelTypeDomain
    var color: String
    
    init(id: String = UUID().uuidString, manufacturer: String = "", name: String = "", plateNumber: String = "", fuelTypeDomain: FuelTypeDomain = .gasoline, color: String = "") {
        self.id = id
        self.manufacturer = manufacturer
        self.name = name
        self.plateNumber = plateNumber
        self.fuelTypeDomain = fuelTypeDomain
        self.color = color
    }
}

extension CarDomain {
    func toDTO() -> Car {
        let dto = Car(manufacturer: manufacturer,
                      name: name,
                      plateNumber: plateNumber,
                      fuelType: fuelTypeDomain.toDTOEnum(),
                      color: color)
        return dto
    }
}

enum FuelTypeDomain: String, CaseIterable {
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

extension FuelTypeDomain {
    func toDTOEnum() -> FuelType {
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
