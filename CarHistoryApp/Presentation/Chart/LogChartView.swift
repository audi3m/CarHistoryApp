//
//  LogChartView.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import SwiftUI
import Charts

struct LogChartView: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    @State private var category = Category.all
    @State private var summaryList = [MonthlySummary]()
     
    var body: some View {
        
        NavigationStack {
            ScrollView {
                categoryPicker()
                charts()
                summaryData()
                
            }
            .navigationTitle("Charts")
            .background(.appBackground)
        }
        .onAppear {
            summaryList = DummyData.summary
        }
    }
}

extension LogChartView {
    @ViewBuilder
    private func categoryPicker() -> some View {
        Picker(selection: $category) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
            }
        } label: {
            Text(category.rawValue)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func charts() -> some View {
        Chart {
            ForEach(summaryList) { data in
                BarMark(
                    x: .value("Date", data.month),
                    y: .value("Fuel Amt", category == .fuelCost ? data.fuelCost : data.repairCost)
                )
            }
        }
        .frame(height: 250)
//                .chartXAxis {
//                    AxisMarks(values: .stride(by: .month)) { value in
//                        AxisGridLine()
//                        AxisValueLabel(format: .dateTime.month())
//                    }
//                }
        .padding()
    }
    
    @ViewBuilder
    private func summaryData() -> some View {
        Text("월별 평균 주유 비용")
        Text("연비")
        Text("평균")
        Text("평균")
    }
}

#Preview {
    LogChartView()
}

enum Category: String, CaseIterable {
    case all = "전체"
//    case mileage = "키로수"
    case fuelCost = "주유 비용"
    case repair = "정비 비용"
}
