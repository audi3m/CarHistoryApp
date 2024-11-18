//
//  LocalDataManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/16/24.
//

import Foundation

final class LocalDataManager: ObservableObject {
    
    private let carService: CarRepository
    private let logService: LogRepository
    
    @Published var cars = [CarDomain]()
    @Published var selectedCar: CarDomain?
    @Published var logs = [LogDomain]()
    
    init(carService: CarRepository, logService: LogRepository) {
        self.carService = carService
        self.logService = logService
    }
    
}

// car
extension LocalDataManager {
    
    func fetchCar() -> CarDomain? {
        let number = BasicSettingsHelper.selectedCarNumber
        let car = cars.first { $0.plateNumber == number }
        return car
    }
    
    func selectCar(car: CarDomain) {
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        selectedCar = car
        fetchLogs(carID: car.id)
    }
    
    func fetchAllCars() {
        cars = carService.fetchAllCars()
    }
    
    func createCar(car: inout CarDomain) {
        car.id = carService.createCar(car: car)
        cars.append(car)
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
extension LocalDataManager {
    
    func fetchLogs(carID: String) {
        logs = logService.fetchLogs(carID: carID)
    }
    
    func createLog(log: inout LogDomain) {
        guard let selectedCar else { return }
        log.id = logService.createLog(to: selectedCar.id, log: log)
        logs.append(log)
    }
    
    func deleteLog(logID: String) {
        guard let selectedCar else { return }
        logs.removeAll { $0.id == logID }
        logService.deleteLog(from: selectedCar.id, logID: logID)
    }
    
    func updateLog(log: LogDomain) {
        
        logService.updateLog(log: log)
    }
    
    //    var filteredLogs: RealmSwift.List<CarLog> {
    //        let filteredList = RealmSwift.List<CarLog>()
    //        let calendar = Calendar.current
    //        let startOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 1, day: 1))!
    //        let endOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 12, day: 31))!
    //
    //        for log in car.logList {
    //            if log.date >= startOfYear && log.date <= endOfYear {
    //                filteredList.append(log)
    //            }
    //        }
    //        return filteredList
    //    }
    
}
