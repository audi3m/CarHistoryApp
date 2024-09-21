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
    
    @State private var showPicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Button {
                        showPicker = true
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
                    .padding(20)
                    
                    VStack(spacing: 12) {
                        CustomTextField(image: "licenseplate", placeHolder: "[필수] 차번호", text: $plateNumber)
                        CustomTextField(image: "building", placeHolder: "[선택] 제조사", text: $manufacturer)
                        CustomTextField(image: "calendar", placeHolder: "[선택] 연식", text: $year)
                    }
                    .padding()
                    
                    HStack {
                        ForEach(FuelType.allCases, id: \.self) { type in
                            VStack {
                                Text(type.rawValue)
                                    .font(.caption)
                                    .foregroundStyle(fuelType == type ? .white : .blackWhite)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(
                                        fuelType == type ? .red : .gray.opacity(0.15)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        withAnimation(.bouncy(duration: 0.2)) {
                                            fuelType = type
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("자동차 등록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("닫기") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        addNewCar()
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(selectedImage: $selectedImage)
                .interactiveDismissDisabled(true)
        }
    }
}

//final class Car: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var manufacturer = ""
//    @Persisted var name = ""
//    @Persisted var plateNumber = ""
//    @Persisted var fuelType = FuelType.gasoline
//    @Persisted var color = "" // 나중에
//    
//    @Persisted var historyList = RealmSwift.List<CarHistory>()
//    
//    
//}


extension CarEnrollView {
    private func addNewCar() {
        let newCar = Car()
        newCar.plateNumber = plateNumber
        newCar.manufacturer = manufacturer
        newCar.fuelType = fuelType
        
        CarRepository.shared.printDirectory()
        
        CarRepository.shared.addNewCar(car: newCar)
    }
}

#Preview {
    CarEnrollView()
}
