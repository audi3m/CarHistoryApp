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
    
    static let shared = CarDataManager()
    private init() {
        initializeRealm()
    }
    
    var realm: Realm!
    
    @Published var yearlyLogList = [CarLog]()
    
    func initializeRealm() {
        do {
            self.realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    
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

// 자동차 이미지 저장
final class CarImageManager {
    static let shared = CarImageManager()
    private init() { }
    
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        guard let data = image.pngData() else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("File save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).png")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("File remove error", error)
            }
            
        } else {
            print("File does not exist")
        }
    }
    
}

