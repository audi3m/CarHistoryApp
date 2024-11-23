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
    
    func selectCar(car: CarDomain) {
        // 차번호 저장
        // selected 변경
        // 로그 불러오기
    }
}

// 최초
extension LocalDataManager {
    
    func fetchAllCars() -> [CarDomain] {
        let list = carService.fetchAllCars()
        return list
    }
    
    func setRecentCar(car: CarDomain) {
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        selectedCar = car
        logs = fetchLogs(of: car.id)
    }
    
    func fetchLogs(of carID: String?) -> [LogDomain] {
        guard let carID else { return [] }
        let list = logService.fetchLogs(carID: carID)
        return list
    }
    
}
    
// car
extension LocalDataManager {
    
    func fetchRecentCar() -> CarDomain? {
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
