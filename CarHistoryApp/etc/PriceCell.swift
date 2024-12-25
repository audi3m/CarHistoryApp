//
//  PriceCell.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/24/24.
//

import SwiftUI

struct PriceCell: View {
    
    var price: Double
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "wonsign.circle")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blackWhite.opacity(0.7))
                .frame(width: 23, height: 23)
            
            Spacer()
            
            HStack {
                Text("리터당")
                Text("\(Int(price))")
                Text("원")
            }
            .frame(minHeight: 23)
        }
        .foregroundStyle(.secondary)
    }
}
