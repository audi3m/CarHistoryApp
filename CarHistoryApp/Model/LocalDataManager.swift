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
        setInitialData()
    }
}

//
extension LocalDataManager {
    private func setInitialData() {
        cars = fetchAllCars()
        selectedCar = fetchRecentCar()
        logs = fetchLogs(of: selectedCar?.id)
    }
}

// 최초
extension LocalDataManager {
    
    private func fetchAllCars() -> [CarDomain] {
        return carService.fetchAllCars()
    }
    
    func selectCar(car: CarDomain) {
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        selectedCar = car
        logs = fetchLogs(of: car.id)
    }
    
    func fetchLogs(of carID: String?) -> [LogDomain] {
        guard let carID else { return [] }
        let list = logService.fetchLogs(carID: carID).sorted { $0.date < $1.date }
        return list
    }
    
}
    
// car
extension LocalDataManager {
    
    private func fetchRecentCar() -> CarDomain? {
        let number = BasicSettingsHelper.selectedCarNumber
        if let car = cars.first(where: { $0.plateNumber == number }) {
            return car
        } else {
            return cars.first
        }
    }
    
    func createCar(car: inout CarDomain) {
        car.id = carService.createCar(car: car)
        cars.append(car)
        selectedCar = car
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        logs = []
    }
    
    func deleteCar(car: CarDomain) {
        cars.removeAll { $0.id == car.id }
        carService.deleteCar(car: car)
        selectedCar = fetchRecentCar()
        logs = fetchLogs(of: selectedCar?.id)
    }
    
    func updateCar(car: CarDomain) {
        carService.updateCar(car: car)
    }
    
}

// log
extension LocalDataManager {
    
    func createLog(log: inout LogDomain) {
        guard let selectedCar else { return }
        log.id = logService.createLog(to: selectedCar.id, log: log)
        logs.append(log)
        logs.sort { $0.date < $1.date }
    }
    
    func deleteLog(logID: String) {
        guard let selectedCar else { return }
        logs.removeAll { $0.id == logID }
        logService.deleteLog(from: selectedCar.id, logID: logID)
    }
    
    func updateLog(log: LogDomain) {
        logService.updateLog(log: log)
    }
    
}

extension LocalDataManager {
    
    func sortByYear(yearOfInterest: Int) -> [LogDomain] {
        var sortedLogs = [LogDomain]()
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: DateComponents(year: yearOfInterest, month: 1, day: 1))!
        let endOfYear = calendar.date(from: DateComponents(year: yearOfInterest, month: 12, day: 31))!
        
        for log in self.logs {
            if log.date >= startOfYear && log.date <= endOfYear {
                sortedLogs.append(log)
            }
        }
        
        return sortedLogs
    }
    
    func getFuelExpense() -> String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        
        let refuelList = logs
            .filter { $0.logType == .refuel }
            .filter {
                let logYear = calendar.component(.year, from: $0.date)
                let logMonth = calendar.component(.month, from: $0.date)
                return logYear == currentYear && logMonth == currentMonth
            }
        
        let totalCost = refuelList.reduce(0) { $0 + $1.totalCost }
        
        return "₩\(Int(totalCost).formatted())"
    }
    
    func getLatestWash() -> String {
        if let wash = logs.last(where: { $0.logType == .carWash }) {
            return wash.date.toSep30()
        } else {
            return "기록 없음"
        }
    }
    
}
