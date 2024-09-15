//
//  CarEnrollView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct CarEnrollView: View {
    @State private var manufacturer = ""
    @State private var number = ""
    @State private var year = ""
    @State private var fuelType = ""
    
    
    var body: some View {
        ScrollView {
            Image("car")
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            
            VStack {
                TextField("제조사", text: $manufacturer)
                TextField("차번호", text: $number)
                TextField("연식", text: $year)
                TextField("연료", text: $fuelType)
            }
            .textFieldStyle(.roundedBorder)
            
            
        }
    }
}

#Preview {
    CarEnrollView()
}
