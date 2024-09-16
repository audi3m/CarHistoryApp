//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct CarEnrollView: View {
    @State private var manufacturer = "현대자동차"
    @State private var number = "123주1234"
    @State private var year = "2023"
    @State private var color = Color.black
    @State private var fuelType = FuelCategory.gasoline
    
    var body: some View {
        ScrollView {
            VStack {
                Image("car")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                VStack {
                    TextField("제조사", text: $manufacturer)
                    TextField("차번호", text: $number)
                    TextField("연식", text: $year)               
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                
                VStack {
                    Picker("연료", selection: $fuelType) {
                        ForEach(FuelCategory.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    ColorPicker("차량 색상", selection: $color)
                }
                .padding()
            }
        }
    }
}

extension CarEnrollView {
    enum FuelCategory: String, CaseIterable {
        case gasoline = "휘발유"
        case diesel = "경유"
        case electric = "전기"
        case hydrogen = "수소"
    }
}

#Preview {
    CarEnrollView()
}
