//
//  CarViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/12/24.
//

import Foundation

final class CarViewModel: ObservableObject {
    
    private let carService: CarRepository
    
    @Published var cars = [CarDomain]()
    @Published var selectedCarID: String
    
    init(carService: CarRealmService, selectedCarID: String) {
        self.carService = CarRealmService()
        self.selectedCarID = selectedCarID
    }
    
}

extension CarViewModel {
    
    @discardableResult
    func fetchCars() -> [CarDomain] {
        cars = carService.fetchCars()
        return []
    }
    
    func createCar(car: CarDomain) {
        cars.append(car)
        carService.createCar(car: car)
    }
    
    func deleteCar(car: CarDomain) {
        cars.removeAll { $0.id == car.id }
        carService.deleteCar(car: car)
    }
    
    func updateCar(car: CarDomain) {
        
        carService.updateCar(car: car)
    }
    
}
