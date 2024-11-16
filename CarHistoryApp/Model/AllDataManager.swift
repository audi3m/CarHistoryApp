//
//  AllDataManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/16/24.
//

import Foundation

final class AllDataManager: ObservableObject {
    
    private let carService: CarRepository
    private let logService: LogRepository
    
    @Published var cars = [CarDomain]()
    @Published var selectedCar: CarDomain?
    @Published var logs = [LogDomain]()
    
    init(carService: CarRepository, logService: LogRepository, selectedCar: CarDomain? = nil) {
        self.carService = carService
        self.logService = logService
        self.selectedCar = selectedCar
    }
    
}

// car
extension AllDataManager {
    
    func fetchSelectedCar() {
//        let id = BasicSettingsHelper.selectedCarNumber
    }
    
    func fetchCars() {
        cars = carService.fetchCars()
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

// log
extension AllDataManager {
    func fetchLogs() {
        guard let carID = selectedCar?.id else { return }
        logs = logService.fetchLogs(carID: carID)
    }
    
    @discardableResult
    func fetchLogs(carID: String) -> [LogDomain] {
        logs = logService.fetchLogs(carID: carID)
        return []
    }
    
    func createLog(log: LogDomain) {
        logs.append(log)
        logService.createLog(log: log)
    }
    
    func deleteLog(logID: String) {
        logs.removeAll { $0.id == logID }
        logService.deleteLog(logID: logID)
    }
    
    func updateLog(log: LogDomain) {
        
        logService.updateLog(log: log)
    }
}
