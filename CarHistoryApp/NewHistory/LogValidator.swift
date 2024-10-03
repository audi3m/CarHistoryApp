//
//  LogValidator.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/29/24.
//

import Foundation
import Combine
import CoreLocation
import RealmSwift

final class LogValidator: ObservableObject {
    
    @Published var logType = LogType.refuel
    @Published var date = Date()
    @Published var mileage = ""
    @Published var companyName = ""
    @Published var totalCost = "" 
    @Published var refuelAmount = 30.0
    @Published var notes = ""
    @Published var coordinates: CLLocationCoordinate2D?
    
    @Published var isValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        combineStart()
    }
    
    private func combineStart() {
        Publishers.CombineLatest($mileage, $totalCost)
            .map { mileage, totalCost in
                guard let _ = Int(mileage), let _ = Double(totalCost) else {
                    return false
                }
                return true
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
    }
    
    func makeNewLog() -> CarLog {
        let newLog = CarLog()
        newLog.logType = logType
        newLog.date = date
        newLog.mileage = Int(mileage) ?? 0
        newLog.companyName = companyName
        newLog.totalCost = Double(totalCost) ?? 0.0
        newLog.refuelAmount = refuelAmount
        newLog.notes = notes
        
        if let coordinates {
            newLog.latitude = coordinates.latitude
            newLog.longitude = coordinates.longitude
        }
        
        return newLog
        
    }
}
