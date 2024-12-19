//
//  HomeViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/16/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var cars: [CarDomain] = []
    @Published var recentFive: [LogDomain] = []
    @Published var fuelCost: String = ""
    @Published var lastWash: String = ""
    
    init() {
        
    }
    
    deinit {
        print("Deinit HomeViewModel")
    }
}

extension HomeViewModel {
    private func getCars() {
        
    }
    
    private func getRecentFive() {
        
    }
    
    private func getFuelCost() {
        
    }
    
    private func getLastWash() {
        
    }
}
