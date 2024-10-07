//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import PhotosUI
import RealmSwift

struct CarEnrollView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedResults(Car.self) var cars
    
    @Binding var addedCar: Car?
    
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
            .navigationTitle("차량 등록")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        addNewCar()
                    }
                    .disabled(plateNumber.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
                .interactiveDismissDisabled(true)
        }
        .alert("이미 등록된 차량입니다", isPresented: $carAlreadyExists) { }
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
                        Text("이미지를 선택하려면 탭하세요")
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
            CustomTextField(image: "licenseplate", placeHolder: "[필수] 차량번호", keyboardType: .default, text: $plateNumber)
            CustomTextField(image: "building.2", placeHolder: "제조사", text: $manufacturer)
            CustomTextField(image: "car.fill", placeHolder: "이름", keyboardType: .default, text: $manufacturer)
            CustomTextField(image: "calendar", placeHolder: "연식", keyboardType: .numberPad, text: $year)
        }
    }
}

extension CarEnrollView {
    private func addNewCar() {
        let carNumbers = cars.map { $0.plateNumber }
        guard !carNumbers.contains(plateNumber) else { 
            carAlreadyExists = true
            return
        }
        
        let newCar = Car()
        newCar.plateNumber = plateNumber
        newCar.manufacturer = manufacturer
        newCar.fuelType = fuelType
        
        $cars.append(newCar)
        if let selectedImage {
            CarImageManager.shared.saveImageToDocument(image: selectedImage, filename: "\(newCar.id)")
        }
        
        addedCar = newCar
        
        dismiss()
    }
}
