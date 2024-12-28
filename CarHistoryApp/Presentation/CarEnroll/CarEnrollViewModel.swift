//
//  CarEnrollViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/19/24.
//

import SwiftUI

final class CarEnrollViewModel: ObservableObject { 
    
    
    
    init() {
        print("init CarEnrollViewModel")
    }
    
    deinit {
        print("deinit CarEnrollViewModel")
    }
    
}

//extension CarEnrollViewModel {
//    func addNewCar() {
//        let carNumbers = dataManager.cars.map { $0.plateNumber }
//        guard !carNumbers.contains(plateNumber) else {
//            carAlreadyExists = true
//            return
//        }
//        
//        var newCar = CarDomain(manufacturer: manufacturer,
//                               name: name,
//                               plateNumber: plateNumber,
//                               fuelTypeDomain: fuelType)
//        
//        dataManager.createCar(car: &newCar)
//        
//        if let image = selectedImage {
//            CarImageManager.saveImageToDocument(image: image, filename: "\(newCar.id)")
//        }
//    }
//}
