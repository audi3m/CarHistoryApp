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
    @Published var recentFive: [LogDomain] = []
    @Published var fuelCost: String = ""
    @Published var lastWash: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let dataManager: LocalDataManager
    
    init(dataManager: LocalDataManager) {
        self.dataManager = dataManager
        
        assignCars()
        assignRecentFive()
        assignLastWash()
        
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
    
    private func assignRecentFive() {
        dataManager.$logs
            .removeDuplicates()
            .map { logs in
                logs.suffix(5).reversed()
            }
            .assign(to: \.recentFive, on: self)
            .store(in: &cancellables)
    }
    
    private func getFuelCost() {
        
    }
    
    private func assignLastWash() {
        dataManager.$logs
            .removeDuplicates()
            .map { [weak self] logs -> String in
                guard let self else { return "" }
                return self.getLastWash(logs: logs)
            }
            .assign(to: \.lastWash, on: self)
            .store(in: &cancellables)
    }
    
}

extension HomeViewModel {
    
    private func getLastWash(logs: [LogDomain]) -> String {
        if let wash = logs.last(where: { $0.logType == .carWash }) {
            return wash.date.toSep30()
        } else {
            return "기록 없음"
        }
    }
}
