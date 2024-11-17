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
    
    init() { }
    
}

extension LogRealmService {
    
    func fetchLogs(carID: String) -> [LogDomain] {
        guard let objectID = try? ObjectId(string: carID),
              let car = realm.object(ofType: Car.self, forPrimaryKey: objectID) else { return [] }
        let logs = car.logList.map { $0.toDomain() }
        return Array(logs)
    }
    
    func createLog(log: LogDomain) {
        let dto = log.toDTO()
        do {
            try realm.write {
                realm.add(dto)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteLog(logID: String) {
        guard let objectID = try? ObjectId(string: logID),
              let logToDelete = realm.object(ofType: CarLog.self, forPrimaryKey: objectID) else { return }
        do {
            try realm.write {
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
