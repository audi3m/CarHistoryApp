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
        x: .value("Date", $0.date),
        y: .value("Fuel Amt", $0.totalCost)
      )
      .foregroundStyle(by: .value("Product Category", $0.totalCost))
    }
    .chartXAxis {
      AxisMarks(format: .dateTime.month(.abbreviated))
    }
    .frame(height: 250)
    .padding()
  }
  
  @ViewBuilder
  private func summaryData() -> some View {
    Text("월평균 주유 비용")
    Text("평균 연비")
    Text("평균")
  }
}
