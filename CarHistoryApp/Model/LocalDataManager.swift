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
        
        fetchAllCars()
        if let selectedCar = fetchRecentCar() {
            fetchLogs(of: selectedCar.id)
        }
    }
    
}

// 최초 
extension LocalDataManager {
    
    func fetchAllCars() {
        cars = carService.fetchAllCars()
    }
    
    func setRecentCar() {
        
        
        
        // selected 설정
        // 체크 표시
        // 리스트 불러오기
    }
    
    func fetchLogs(of carID: String) {
        logs = logService.fetchLogs(carID: carID)
    }
    
}
    
// car
extension LocalDataManager {
    
    func fetchRecentCar() -> CarDomain? {
        let number = BasicSettingsHelper.selectedCarNumber
        return cars.first { $0.plateNumber == number }
    }
    
    
    func selectCar(car: CarDomain) {
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        selectedCar = car
        fetchLogs(of: car.id)
    }
    
    
    func createCar(car: inout CarDomain) {
        car.id = carService.createCar(car: car)
        cars.append(car)
    }
    
    func deleteCar(car: CarDomain) {
        cars.removeAll { $0.id == car.id }
        carService.deleteCar(car: car)
    }
    
    func isSelectedCar(car: CarDomain) -> Bool {
        if let selectedCar, selectedCar == car { return true }
        else { return false}
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
