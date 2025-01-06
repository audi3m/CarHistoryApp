//
//  Untitled.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/30/24.
//

import SwiftUI
import Charts

struct ChartsTestView: View {
    
    @State private var list = [LogTest]()
    @State private var filterType = FilterTestType.all
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Picker(selection: $filterType) {
                    ForEach(FilterTestType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                } label: {
//                    Text(filterType.rawValue)
                    Text("asdasd")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Chart(list) {
                    BarMark(x: .value("Date", $0.date),
                            y: .value("Cost", $0.value))
                    .foregroundStyle(by: .value("Type", $0.type.rawValue))
                }
                .frame(height: 250)
//                .chartForegroundStyleScale([
//                    "주유": .brown,
//                    "정비": .purple
//                ])
//                .chartXAxis {
//                    AxisMarks(format: .dateTime.month(.abbreviated)) // "Jul", "Aug" 형식
//                }
                .padding()
            }
            .navigationTitle("Charts")
        }
        .onAppear {
            list = TestDummy.mockData
                .sorted { $0.date < $1.date }
                .sorted { $0.type.rawValue < $1.type.rawValue}
        }
    }
}

enum FilterTestType: String, CaseIterable {
    case all = "전체"
    case refuel = "주유"
    case repair = "정비"
}

#Preview {
    ChartsTestView()
}
