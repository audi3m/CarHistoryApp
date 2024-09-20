//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import PhotosUI

struct CarEnrollView: View {
    @State private var manufacturer = "현대자동차"
    @State private var number = "123주1234"
    @State private var year = "2023"
    @State private var color = Color.black
    @State private var fuelType = FuelType.gasoline
    
    @State private var showPicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                Button {
                    showPicker = true
                } label: {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 120)
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
                
                VStack(spacing: 12) {
                    CustomTextField(image: "dollarsign", placeHolder: "제조사", text: $manufacturer)
                    CustomTextField(image: "licenseplate", placeHolder: "차번호", text: $number)
                    CustomTextField(image: "calendar", placeHolder: "연식", text: $year)
                }
                .padding()
                
                VStack {
                    Picker("연료", selection: $fuelType) {
                        ForEach(FuelType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    ColorPicker("차량 색상", selection: $color)
                }
                .padding()
            }
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    CarEnrollView()
}
