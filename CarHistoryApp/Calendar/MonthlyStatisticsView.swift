//
//  MonthlyStatisticsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI

struct MonthlyStatisticsView: View {
    
    @State private var date = Date.now
    
    var body: some View {
        ScrollView {
            DatePicker("날짜", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
        }
    }
}

#Preview {
    MonthlyStatisticsView()
}
