//
//  FuelCostView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/20/24.
//

/*
 ------------------------
 |                      |
 |  |                   |
 |  |         .. ..     |
 |  |..    ..           |
 |  |   ..              |
 |  |                   |
 |  ------------------  |
 |  평균연비              |
 |  월평균 주유비용         |
 |                      |
 |                      |
 | <        9월        > |
 | - 주유 1              |
 | - 주유 2              |
 | - 주유 3              |
 |                      |
 ------------------------
 */

import SwiftUI
import Charts

struct FuelCostView: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    var body: some View {
        let calendar = Calendar.current
        let currentDate = Date()

        let filteredFuel = DummyData.fuelAmount.filter { data in
            guard let threeMonthsAgo = calendar.date(byAdding: .month, value: -5, to: currentDate) else { return false }
            return data.date >= threeMonthsAgo
        }

        let groupedByMonth = Dictionary(grouping: filteredFuel) { data in
            calendar.dateComponents([.year, .month], from: data.date)
        }.map { (key, values) -> (String, Double) in
            let totalAmount = values.reduce(0) { $0 + $1.amount }
            let monthName = calendar.monthSymbols[key.month! - 1]
            return (monthName, totalAmount)
        }.sorted { $0.0 < $1.0 }
        
        ScrollView {
            Chart {
                ForEach(groupedByMonth, id: \.0) { (monthName, totalAmount) in
                    BarMark(
                        x: .value("Month", monthName),
                        y: .value("Total Amount", totalAmount)
                    )
                }
            }
            .frame(height: 250)
            .padding()
        }
        .navigationTitle("Monthly Fuel Charges")
        .onAppear {
            dump(DummyData.fuelAmount)
        }
    }
}

#Preview {
    FuelCostView()
}
