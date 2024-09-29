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
    private init() { }
    
    let realm = try! Realm()
    
    @Published var cars: [Car] = []
    @Published var historyList: [CarHistory] = []
    
    func printDirectory() {
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "NOT FOUND")
    }
}

extension CarDataManager {
    func calculateMonthlyMileage(month: Int, year: Int) -> Double {
        // 해당 차량의 모든 주행 기록을 날짜순으로 정렬
        let sortedHistory = historyList.sorted { $0.date < $1.date }
        
        // 이전 달의 마지막 주행 기록을 찾음 (기록이 없으면 nil)
        let previousMonthLastEntry = sortedHistory.last { history in
            let historyMonth = Calendar.current.component(.month, from: history.date)
            let historyYear = Calendar.current.component(.year, from: history.date)
            return historyYear == year && historyMonth == month - 1
        }
        
        // 이전 달 마지막 주행거리 (기록이 없으면 0으로 처리)
        let previousMonthMileage = Double(previousMonthLastEntry?.mileage ?? "0") ?? 0
        
        // 이번 달의 주행 기록들을 필터링
        let currentMonthEntries = sortedHistory.filter { history in
            let historyMonth = Calendar.current.component(.month, from: history.date)
            let historyYear = Calendar.current.component(.year, from: history.date)
            return historyYear == year && historyMonth == month
        }
        
        // 만약 이번 달 첫 번째 기록이 이전 달 기록보다 적다면 첫 기록을 기준으로 시작
        var lastMileage = currentMonthEntries.first.flatMap { Double($0.mileage) } ?? previousMonthMileage
        
        // 이번 달 총 주행거리 계산
        var totalMileage: Double = 0
        
        for entry in currentMonthEntries {
            if let currentMileage = Double(entry.mileage) {
                totalMileage += currentMileage - lastMileage
                lastMileage = currentMileage
            }
        }
        
        return totalMileage
    }
}

// 자동차 CRUD
extension CarDataManager {
    
    func fetchCars() {
        let results = realm.objects(Car.self)
        cars = Array(results)
    }
    
    func addNewCar(car: Car, image: UIImage?) {
        do {
            try realm.write {
                realm.add(car)
            }
            if let image {
                saveImageToDocument(image: image, filename: "\(car.id)")
            }
            fetchCars()
        } catch {
            print("Error adding car: \(error)")
        }
    }
    
    func deleteCar(car: Car) {
        do {
            try realm.write {
                realm.delete(car)
            }
            removeImageFromDocument(filename: "\(car.id)")
            fetchCars()
        } catch {
            print("Error deleting car: \(error)")
        }
    }
    
    func editCar(car: Car, newName: String) {
        do {
            try realm.write {
                car.name = newName
            }
            fetchCars()
        } catch {
            print("Error editing car: \(error)")
        }
    }
}

// 히스토리 CRUD
extension CarDataManager {
    
    func fetchHistories(for car: Car?) {
        guard let car else {
            historyList = []
            return
        }
        let results = realm.objects(CarHistory.self).filter { $0.car == car }
        historyList = Array(results)
    }
    
    func addNewHistory(history: CarHistory) {
        do {
            try realm.write {
                realm.add(history)
            }
            fetchCars()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func deleteHistory(history: CarHistory) {
        do {
            try realm.write {
                realm.delete(history)
            }
            fetchHistories(for: history.car)
        } catch {
            print("Error deleting history: \(error)")
        }
    }
    
    func editHistory(history: CarHistory) {
        do {
            try realm.write {
                
            }
            fetchHistories(for: history.car)
        } catch {
            print("Error editing history: \(error)")
        }
    }
}

// 자동차 이미지 저장
extension CarDataManager {
    
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

