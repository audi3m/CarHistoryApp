//
//  CarViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/12/24.
//

import Foundation

final class CarViewModel: ObservableObject {
    
    private let service: CarRepository
    
    @Published var cars = [CarDomain]()
    @Published var selectedCar: CarDomain
    
    init(service: CarRealmService, cars: [CarDomain] = [CarDomain](), selectedCar: CarDomain) {
        self.service = CarRealmService()
        self.cars = cars
        self.selectedCar = selectedCar
    }
    
    
    
    
    
    
    
    
}
