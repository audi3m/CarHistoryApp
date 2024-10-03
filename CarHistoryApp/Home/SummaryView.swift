//
//  SummaryView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/28/24.
//

import SwiftUI
import Charts

struct SummaryView: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    var body: some View {
        let filteredMileage = DummyData.mileage.filter { data in
            guard let threeMonthsAgo = calendar.date(byAdding: .month, value: -3, to: currentDate) else { return false }
            return data.date >= threeMonthsAgo
        }
        
        ScrollView {
            Chart {
                ForEach(filteredMileage) { data in
                    LineMark(
                        x: .value("Date", data.date),
                        y: .value("Mileage", data.mileage)
                    )
                }
            }
            .frame(height: 250)
            .chartYScale(domain: 15000...18000)
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month())
                }
            }
            .padding()
        }
        .navigationTitle("Chart")
        .background(.appBackground)
    }
}

#Preview {
    SummaryView()
}
