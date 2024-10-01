//
//  YearlyLogView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/30/24.
//

import SwiftUI
import RealmSwift

struct YearlyLogView: View {
    
    let car: Car
    @ObservedResults(CarLog.self) var allLogs
    
    var filteredLogs: Results<CarLog> {
        let calendar = Calendar.current
        let startOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 1, day: 1))!
        let endOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 12, day: 31))!
        return allLogs.filter("date >= %@ AND date <= %@", startOfYear, endOfYear)
    }
    
    @StateObject private var carManager = CarDataManager.shared
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    var body: some View {
        VStack {
            yearSelector()
            
            if filteredLogs.isEmpty {
                ContentUnavailableView("No Logs", systemImage: "tray.2",
                                       description: Text("There are no logs for \(String(selectedYear))"))
                .padding(.bottom, 100)
                
            } else {
                List {
                    ForEach(filteredLogs) { log in
                        logCell(log)
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deleteLog(log)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    
                    Spacer(minLength: 100)
                        .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Logs")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

extension YearlyLogView {
    private func deleteLog(_ log: CarLog) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.delete(log)
            }
        }
    }
}

extension YearlyLogView {
    private func yearSelector() -> some View {
        HStack(spacing: 50) {
            Button {
                selectedYear -= 1
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .disabled(selectedYear <= 2000)
            
            Text(String(selectedYear))
                .font(.title.bold())
            
            Button {
                selectedYear += 1
            } label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .disabled(selectedYear >= Calendar.current.component(.year, from: Date()))
            
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
    }
    
    private func logCell(_ log: CarLog) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 2.5, height: 35)
                .foregroundStyle(log.typeColor)
            
            Image(systemName: log.logType.image)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(5)
            
            VStack(alignment: .leading) {
                Text(log.companyName)
                    .font(.footnote)
                
                Text(log.subDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            Text(DateHelper.shared.shortFormat(date: log.date))
                .font(.caption)
        }
        .padding(.horizontal, 10)
        .frame(height: 60)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


