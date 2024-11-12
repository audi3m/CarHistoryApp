//
//  CarRepositoryProtocol.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/20/24.
//

import Foundation
import RealmSwift

protocol CarRepository {
    func fetchCars() -> [CarDomain]
    func createCar(car: CarDomain)
    func deleteCar(car: CarDomain)
    func updateCar(car: CarDomain)
}

