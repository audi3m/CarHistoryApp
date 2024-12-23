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
    
    @StateObject private var vm = LogChartViewModel()
     
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
    }
}

extension LogChartView {
    @ViewBuilder
    private func categoryPicker() -> some View {
        Picker(selection: $vm.category) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
            }
        } label: {
            Text(vm.category.rawValue)
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func charts() -> some View {
        Chart {
            ForEach(vm.filteredData) { data in
                BarMark(
                    x: .value("Date", data.month),
                    y: .value("Fuel Amt", data.value)
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
        Text("월평균 주유 비용")
        Text("평균 연비")
        Text("평균")
    }
}

#Preview {
    LogChartView()
}


