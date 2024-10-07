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
    @Published var refuelInt = 30.0
    @Published var refuelPoint = 0.0
    @Published var notes = ""
    @Published var coordinates: CLLocationCoordinate2D?
    
    @Published var mileageErrorMessage = ""
    @Published var costErrorMessage = ""
    
    @Published var isValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        combineStart()
    }
    
    private var validUsernamePublisher: AnyPublisher<Bool, Never> {
        $mileage
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { Int($0) != nil }
            .eraseToAnyPublisher()
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
        newLog.refuelAmount = refuelInt + refuelPoint * 0.1
        newLog.notes = notes
        
        if let coordinates {
            newLog.latitude = coordinates.latitude
            newLog.longitude = coordinates.longitude
        }
        
        return newLog
        
    }
}
