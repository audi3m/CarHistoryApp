//
//  NewLogViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/29/24.
//

import Foundation
import Combine
import CoreLocation

final class NewLogViewModel: ObservableObject {
    
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
    
    deinit {
        print("Deinit NewLogViewModel")
    }
    
}

extension NewLogViewModel {
    
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
    
    func makeNewLog() -> LogDomain {
        var newLog = LogDomain(date: date,
                               logType: logType,
                               companyName: companyName,
                               mileage: Int(mileage) ?? 0,
                               totalCost: Double(totalCost) ?? 0.0,
                               refuelAmount: refuelInt + refuelPoint * 0.1,
                               notes: notes)
        
        if let coordinates {
            newLog.latitude = coordinates.latitude
            newLog.longitude = coordinates.longitude
        }
        
        return newLog
        
    }
}
