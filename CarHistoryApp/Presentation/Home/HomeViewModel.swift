//
//  HomeViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/16/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var cars: [CarDomain] = []
    @Published var selectedCar: CarDomain? 
    
    private let dataManager: LocalDataManager
    private var cancellables = Set<AnyCancellable>()
    
    var recentFiveLogs: [LogDomain] {
        dataManager.logs.suffix(5).reversed()
    }
    
    var lastWash: String {
        if let wash = dataManager.logs.last(where: { $0.logType == .carWash }) {
            return wash.date.toSep30()
        } else {
            return "기록 없음"
        }
    }
    
    var fuelExpense: String {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        
        let refuelList = dataManager.logs
            .filter { $0.logType == .refuel }
            .filter {
                let logYear = calendar.component(.year, from: $0.date)
                let logMonth = calendar.component(.month, from: $0.date)
                return logYear == currentYear && logMonth == currentMonth
            }
        
        let totalCost = refuelList.reduce(0) { $0 + $1.totalCost }
        
        return "₩\(Int(totalCost).formatted())"
    }
    
    
    init(dataManager: LocalDataManager) {
        self.dataManager = dataManager
        assignCars()
        selectedCar = dataManager.selectedCar
        print("init HomeViewModel")
    }
    
    deinit {
        print("deinit HomeViewModel")
    }
}

// combine
extension HomeViewModel {
    private func assignCars() {
        dataManager.$cars
            .assign(to: \.cars, on: self)
            .store(in: &cancellables)
    }
    
    private func cancelCombine() {
        cancellables.removeAll()
    }
    
}

extension HomeViewModel {
    func selectCar(car: CarDomain) {
        BasicSettingsHelper.selectedCarNumber = car.plateNumber
        selectedCar = car
        dataManager.selectCar(car: car)
    }
}
