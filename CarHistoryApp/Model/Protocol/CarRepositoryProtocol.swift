//
//  CarRepositoryProtocol.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/20/24.
//

import Foundation

protocol CarRepository {
  func fetchAllCars() -> [CarDomain]
  func fetchCar(carID: String) -> CarDomain?
  func createCar(car: CarDomain) -> String
  func deleteCar(car: CarDomain)
  func updateCar(car: CarDomain)
}

