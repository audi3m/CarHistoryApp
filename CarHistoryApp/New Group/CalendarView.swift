//
//  CalendarView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/26/24.
//

import SwiftUI

struct MonthlyEventsView: View {
    @State private var currentDate = Date()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy\nLLLL"
        return formatter
    }

    private var events: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let currentMonth = formatter.string(from: currentDate)
        return ["Event A in \(currentMonth)", "Event B in \(currentMonth)", "Event C in \(currentMonth)"]
    }
    
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack(spacing: 50) {
                    Button(action: {
                        changeMonth(by: -1)
                    }) {
                        Image(systemName: "chevron.left")
                    }

                    Text(dateFormatter.string(from: currentDate))
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        changeMonth(by: 1)
                    }) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                
                VStack {
                    ForEach(events, id: \.self) { event in
                        Text(event)
                    }
                }

                Spacer()
            }
            .navigationTitle("Monthly Events")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MonthlyEventsView()
}
