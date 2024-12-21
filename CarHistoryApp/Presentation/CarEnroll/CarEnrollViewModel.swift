//
//  CarEnrollViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/19/24.
//

import SwiftUI

final class CarEnrollViewModel: ObservableObject {
    
    @Published var manufacturer = ""
    @Published var plateNumber = ""
    @Published var year = ""
    @Published var name = ""
    @Published var carColor = Color.black
    @Published var fuelType = FuelTypeDomain.gasoline
    
    @Published var showImagePicker = false
    @Published var selectedImage: UIImage?
    
    @Published var carAlreadyExists = false
    
    init() {
        
    }
    
    deinit {
        print("Deinit CarEnrollViewModel")
    }
    
    
    
}

extension CarEnrollViewModel {
    func addNewCar() {
        let carNumbers = dataManager.cars.map { $0.plateNumber }
        guard !carNumbers.contains(plateNumber) else {
            carAlreadyExists = true
            return
        }
        
        var newCar = CarDomain(manufacturer: manufacturer,
                               name: name,
                               plateNumber: plateNumber,
                               fuelTypeDomain: fuelType)
        
        dataManager.createCar(car: &newCar)
        
        if let image = selectedImage {
            CarImageManager.saveImageToDocument(image: image, filename: "\(newCar.id)")
        }
    }
}
