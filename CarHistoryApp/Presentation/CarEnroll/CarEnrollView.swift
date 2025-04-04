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
  
  @State private var manufacturer = ""
  @State private var plateNumber = ""
  @State private var year = ""
  @State private var name = ""
  @State private var carColor = Color.black
  @State private var fuelType = FuelTypeDomain.gasoline
  
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
        if let image = selectedImage {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 150)
        } else {
          VStack(spacing: 10){
            Image(systemName: SystemNameKeys.car)
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
        ForEach(FuelTypeDomain.allCases, id: \.self) { type in
          Text(type.rawValue)
        }
      }
      .foregroundStyle(.blackWhite.opacity(0.7))
      .tint(.blackWhite)
    }
  }
  
  private func carDetailSection() -> some View {
    Section {
      CustomTextField(image: SystemNameKeys.licenseplate, placeHolder: "[필수] 차량번호", keyboardType: .default, text: $plateNumber)
      CustomTextField(image: SystemNameKeys.buildings, placeHolder: "제조사", keyboardType: .default, text: $manufacturer)
      CustomTextField(image: SystemNameKeys.carFill, placeHolder: "이름", keyboardType: .default, text: $name)
      CustomTextField(image: SystemNameKeys.calendar, placeHolder: "연식", keyboardType: .numberPad, text: $year)
    }
  }
}

extension CarEnrollView {
  private func addNewCar() {
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
    
    dismiss()
  }
}
