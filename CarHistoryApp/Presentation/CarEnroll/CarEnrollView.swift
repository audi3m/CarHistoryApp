//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct CarEnrollView: View {
    
    @EnvironmentObject var dataManager: LocalDataManager
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var vm = CarEnrollViewModel()
    
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
                    .disabled(vm.plateNumber.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled(true)
        .sheet(isPresented: $vm.showImagePicker) {
            ImagePicker(selectedImage: $vm.selectedImage)
                .interactiveDismissDisabled(true)
        }
        .alert("이미 등록된 차량입니다", isPresented: $vm.carAlreadyExists) { }
    }
}

extension CarEnrollView {
    
    private func imagePickerSection() -> some View {
        Section {
            Button {
                vm.showImagePicker = true
            } label: {
                if let image = vm.selectedImage {
                    Image(uiImage: image)
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
            Picker("", systemImage: vm.fuelType.image, selection: $vm.fuelType) {
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
            CustomTextField(image: "licenseplate", placeHolder: "[필수] 차량번호", keyboardType: .default, text: $vm.plateNumber)
            CustomTextField(image: "building.2", placeHolder: "제조사", keyboardType: .default, text: $vm.manufacturer)
            CustomTextField(image: "car.fill", placeHolder: "이름", keyboardType: .default, text: $vm.name)
            CustomTextField(image: "calendar", placeHolder: "연식", keyboardType: .numberPad, text: $vm.year)
        }
    }
}

extension CarEnrollView {
    private func addNewCar() {
        let carNumbers = dataManager.cars.map { $0.plateNumber }
        guard !carNumbers.contains(vm.plateNumber) else {
            vm.carAlreadyExists = true
            return
        }
        
        var newCar = CarDomain(manufacturer: vm.manufacturer,
                               name: vm.name,
                               plateNumber: vm.plateNumber,
                               fuelTypeDomain: vm.fuelType)
        
        dataManager.createCar(car: &newCar)
        
        if let image = vm.selectedImage {
            CarImageManager.saveImageToDocument(image: image, filename: "\(newCar.id)")
        }
        
        dismiss()
    }
}
