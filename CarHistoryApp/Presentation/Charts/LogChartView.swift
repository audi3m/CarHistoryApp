//
//  LogChartView.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/18/24.
//

import SwiftUI
import Charts

struct LogChartView: View { 
    
    @StateObject private var vm: LogChartViewModel
    @State private var selectedMonth: String?
    
    init(dataManager: LocalDataManager) {
        _vm = StateObject(wrappedValue: LogChartViewModel(dataManager: dataManager))
    }
     
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
        Chart(vm.filteredData) {
            BarMark(
                x: .value("Date", $0.month),
                y: .value("Fuel Amt", $0.value)
            )
            .foregroundStyle(by: .value("Product Category", $0.value))
//            .annotation(position: .top, alignment: .center) {
//                if selectedMonth == data.month {
//                    Text("\(data.value, specifier: "%.1f")")
//                        .font(.caption)
//                        .foregroundColor(.blue)
//                        .bold()
//                }
//            }
//            .onTapGesture {
//                if selectedMonth == data.month {
//                    selectedMonth = nil
//                } else {
//                    selectedMonth = data.month
//                }
//            }
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
