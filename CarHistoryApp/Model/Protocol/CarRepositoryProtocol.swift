//
//  CarRepositoryProtocol.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/20/24.
//

import Foundation
import RealmSwift

protocol CarRepository {
    func fetchAllCars() -> [CarDomain]
    func fetchCar(carID: String) -> CarDomain?
    func createCar(car: CarDomain)
    func deleteCar(car: CarDomain)
    func updateCar(car: CarDomain)
}

