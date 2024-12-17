//
//  LogRealmService.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation
import RealmSwift

final class LogRealmService: LogRepository {
    
    private let realm = try! Realm()
    
}

extension LogRealmService {
    
    func fetchLogs(carID: String) -> [LogDomain] {
        guard let objectID = try? ObjectId(string: carID),
              let car = realm.object(ofType: Car.self, forPrimaryKey: objectID) else { return [] }
        let logs = car.logList.map { $0.toDomain() }
        return Array(logs).sorted { $0.date < $1.date }
    }
    
    func createLog(to carID: String, log: LogDomain) -> String {
        let logDTO = log.toDTO()
        guard let carID = try? ObjectId(string: carID),
              let carDTO = realm.object(ofType: Car.self, forPrimaryKey: carID) else { return "Fail to convert to DTO" }
        do {
            try realm.write {
                carDTO.logList.append(logDTO)
            }
        } catch {
            print(error.localizedDescription)
        }
        return logDTO.id.stringValue
    }
    
    func deleteLog(from carID: String, logID: String) {
        guard let carObjectID = try? ObjectId(string: carID),
              let linkedCar = realm.object(ofType: Car.self, forPrimaryKey: carObjectID) else { return }
        guard let logObjectID = try? ObjectId(string: logID),
              let logToDelete = realm.object(ofType: CarLog.self, forPrimaryKey: logObjectID) else { return }
        do {
            try realm.write {
                if let index = linkedCar.logList.firstIndex(of: logToDelete) {
                    linkedCar.logList.remove(at: index)
                }
                realm.delete(logToDelete)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateLog(log: LogDomain) {
        guard let objectID = try? ObjectId(string: log.id),
              let logToEdit = realm.object(ofType: CarLog.self, forPrimaryKey: objectID) else { return }
        
        
        do {
            try realm.write {
                realm.add(logToEdit, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
