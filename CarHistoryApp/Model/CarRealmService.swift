//
//  CarRealmService.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation
import RealmSwift

final class CarRealmService: CarRepositoryProtocol {
    
    private let realm = try! Realm()
    
    init() { }
    
}

extension CarRealmService {
    
    func fetchCars() -> [CarDomain] {
        return realm.objects(Car.self).map { $0.toDomain() }
    }
    
    func createCar(car: CarDomain) {
        let car = car.toDTO()
        do {
            try realm.write {
                realm.add(car)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCar(car: CarDomain) {
        guard let objectID = try? ObjectId(string: car.id),
              let carToDelete = realm.object(ofType: Car.self, forPrimaryKey: objectID) else { return }
        do {
            try realm.write {
                realm.delete(carToDelete.logList)
                realm.delete(carToDelete)
            }
        } catch {
            print("RealmError.deleteError")
        }
    }
    
    func updateCar(car: CarDomain) {
        guard let objectID = try? ObjectId(string: car.id),
              let carToEdit = realm.object(ofType: Car.self, forPrimaryKey: objectID) else { return }
        
        carToEdit.name = car.name
        carToEdit.plateNumber = car.plateNumber
        carToEdit.fuelType = car.fuelTypeDomain.toDTOEnum()
        carToEdit.color = car.color
        carToEdit.manufacturer = car.manufacturer
        
        do {
            try realm.write {
                realm.add(carToEdit, update: .modified)
            }
        } catch {
            print("RealmError.updateError")
        }
    }
    
}
