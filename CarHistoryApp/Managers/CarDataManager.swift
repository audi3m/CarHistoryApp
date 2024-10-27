//
//  CarDataManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI
import RealmSwift

// 기본 프로퍼티 & 메서드
final class CarDataManager: ObservableObject {
    
    private let realm = try! Realm()
    
    static let shared = CarDataManager()
    private init() { }
    
    @Published var yearlyLogList = [CarLog]()
    
    func printDirectory() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "NOT FOUND")
    }
    
}

extension CarDataManager {
    func fetchYearlyLogs(car: Car, of year: Int) {
        
    }
    
    func getMonthlyFuelCost(car: Car, month: Int) -> Double {
        0.0
    }
    
    func getLastCarWashDate() -> String {
        ""
    }
}

// 자동차 CRUD
extension CarDataManager {
    func addNewCar(car: Car) {
        do {
            try realm.write {
                realm.add(car)
            }
        } catch {
            print("Error adding car: \(error)")
        }
    }
    
    func deleteCar(car: Car) {
        do {
            try realm.write {
                realm.delete(car)
            }
        } catch {
            print("Error deleting car: \(error)")
        }
    }
    
    func editCar(car: Car, newName: String) {
        do {
            try realm.write {
                car.name = newName
            }
        } catch {
            print("Error editing car: \(error)")
        }
    }
}

// 히스토리 CRUD
extension CarDataManager {
    
    func addNewLog(log: CarLog) {
        do {
            try realm.write {
                realm.add(log)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func deleteLog(log: CarLog) {
        do {
            try realm.write {
                realm.delete(log)
            }
        } catch {
            print("Error deleting log: \(error)")
        }
    }
    
    func editLog(log: CarLog) {
        do {
            try realm.write {
                
            }
        } catch {
            print("Error editing log: \(error)")
        }
    }
}
