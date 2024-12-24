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
    
    @Published var mileageErrorMessage: String?
    @Published var costErrorMessage: String?
    
    @Published var isValid: Bool = false
    
    var price: Double {
        if let cost = Double(totalCost) {
            return cost / (refuelInt + refuelPoint)
        } else {
            return 0.0
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        print("init NewLogViewModel")
        combine()
    }
    
    deinit {
        print("deinit NewLogViewModel")
    }
    
}

extension NewLogViewModel {
     
    private func combine() {
        $mileage
            .map { mileage -> String? in
                if mileage.isEmpty {
                    return nil
                } else if Int(mileage) != nil {
                    return nil
                } else {
                    return "[주행거리] 정수로 입력해주세요"
                }
            }
            .sink { [weak self] message in
                guard let self else { return }
                self.mileageErrorMessage = message
            }
            .store(in: &cancellables)
        
        $totalCost
            .map { cost -> String? in
                if cost.isEmpty {
                    return nil
                } else if Int(cost) != nil {
                    return nil
                } else {
                    return "[총비용] 정수로 입력해주세요"
                }
            }
            .sink { [weak self] message in
                guard let self else { return }
                self.costErrorMessage = message
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($mileage, $totalCost)
            .map { mileage, totalCost in
                guard let _ = Int(mileage), let _ = Double(totalCost) else { return false }
                return true
            }
            .sink { [weak self] isValid in
                guard let self else { return }
                self.isValid = isValid
            }
            .store(in: &cancellables)
    }
    
    func makeNewLog() -> LogDomain {
        var newLog = LogDomain(date: date,
                               logType: logType.toDomain(),
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
    
    func clearSubscription() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
