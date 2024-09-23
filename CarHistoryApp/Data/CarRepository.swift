//
//  CarRepository.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import Foundation
import RealmSwift

final class CarRepository {
    static let shared = CarRepository()
    private init() { }
    
    let realm = try! Realm()
    
    @ObservedResults(Car.self) var cars
    @ObservedResults(CarHistory.self) var historyList
    
    func addNewCar(car: Car) {
        $cars.append(car)
    }
    
    func deleteCar(car: Car) {
        $cars.remove(car)
    }
    
    func printDirectory() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "NOT FOUND")
    }
    
    func addNewHistory(history: CarHistory, to car: Car) {
//        history.car = car
        $historyList.append(history)
        
    }
    
}
