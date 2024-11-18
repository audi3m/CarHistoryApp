//
//  CarTestService.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/17/24.
//

import Foundation

final class CarTestService: CarRepository {
    // Test
    
}

extension CarTestService {
    
    func fetchAllCars() -> [CarDomain] {
        return []
    }
    
    func fetchCar(carID: String) -> CarDomain? {
        return nil
    }
    
    func createCar(car: CarDomain) -> String {
        return ""
    }
    
    func deleteCar(car: CarDomain) {
        
    }
    
    func updateCar(car: CarDomain) {
        
    }
    
}

