//
//  CarDomain.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation

struct CarDomain: Identifiable {
    
    var id = UUID().uuidString
    let manufacturer: String
    let name: String
    let plateNumber: String
    let fuelTypeDomain: FuelTypeDomain
    let color: String
    
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
