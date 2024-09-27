//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import PhotosUI

struct CarEnrollView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var manufacturer = ""
    @State private var plateNumber = ""
    @State private var year = ""
    @State private var carColor = Color.black
    @State private var fuelType = FuelType.gasoline
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @State private var carAlreadyExists = false
    
    var body: some View {
        NavigationStack {
            List {
                imagePickerSection()
                fuelTypeSelectSection()
                carDetailSection()
                
            }
            .navigationTitle("Car Enroll")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        addNewCar()
                    }
                    .disabled(plateNumber.isEmpty)
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
                .interactiveDismissDisabled(true)
        }
        .alert("This Vehicle is already registered", isPresented: $carAlreadyExists) { }
    }
}

extension CarEnrollView {
    
    private func imagePickerSection() -> some View {
        Section {
            Button {
                showImagePicker = true
            } label: {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 150)
                } else {
                    VStack(spacing: 10){
                        Image(systemName: "car.side")
                            .font(.system(size: 60, weight: .ultraLight))
                            .foregroundStyle(.secondary)
                        Text("Tap to Select an Image")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .foregroundStyle(.blackWhite)
                    .frame(width: 300, height: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 0.3)
                            .foregroundStyle(.blackWhite)
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        .listRowBackground(Color.clear)
        
    }
    
    private func fuelTypeSelectSection() -> some View {
        Section {
            Picker("", systemImage: fuelType.image, selection: $fuelType) {
                ForEach(FuelType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .foregroundStyle(.blackWhite.opacity(0.7))
            .tint(.blackWhite)
        }
    }
    
    private func carDetailSection() -> some View {
        Section {
            CustomTextField(image: "licenseplate", placeHolder: "Plate Number *", keyboardType: .default, text: $plateNumber)
            CustomTextField(image: "building.2", placeHolder: "Manufacturer", text: $manufacturer)
            CustomTextField(image: "car.fill", placeHolder: "Name", keyboardType: .default, text: $manufacturer)
            CustomTextField(image: "calendar", placeHolder: "Model Year", keyboardType: .numberPad, text: $year)
        } footer: {
            HStack {
                Spacer()
                Text("* Required")
            }
        }
    }
}

extension CarEnrollView {
    private func addNewCar() {
        let carNumbers = CarDataManager.shared.cars.map { $0.plateNumber }
        guard !carNumbers.contains(plateNumber) else { 
            carAlreadyExists = true
            return
        }
        
        let newCar = Car()
        newCar.plateNumber = plateNumber
        newCar.manufacturer = manufacturer
        newCar.fuelType = fuelType
        
        if let selectedImage {
            CarDataManager.shared.saveImageToDocument(image: selectedImage, filename: "\(newCar.id)")
        }
        
        CarDataManager.shared.addNewCar(car: newCar)
        dismiss()
    }
}

#Preview {
    CarEnrollView()
}
