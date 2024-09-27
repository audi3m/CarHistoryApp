//
//  MileageView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/20/24.
//

/*
 ----------------------ㄱ
 |  |                   |
 |  |         .. ..     |
 |  |..    ..           |
 |  |   ..              |
 |  |                   |
 |  ㄴ----------------  |
 |                      |
 |  평균연비              |
 |  월평균 주행거리         |
 |                      |
 | <        9월        > |
 |                      |
 |                      |
 |                      |
 ㄴ----------------------
 */


import SwiftUI
import Charts

struct MileageView: View {
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
    }
}

#Preview {
    MileageView()
}
