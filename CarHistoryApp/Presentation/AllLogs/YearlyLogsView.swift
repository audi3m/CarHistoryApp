//
//  YearlyLogsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/30/24.
//

import SwiftUI

struct YearlyLogsView: View {
  @EnvironmentObject var dataManager: LocalDataManager
  
  @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
  @State private var monthlyLogs = [Int: [LogDomain]]()
  
  var body: some View {
    VStack {
      if monthlyLogs.isEmpty {
        ContentUnavailableView("비어있음",
                               systemImage: SystemNameKeys.tray2,
                               description: Text("\(String(selectedYear))년 기록이 없습니다"))
        .padding(.bottom, 100)
      } else {
        List {
          ForEach(Array(stride(from: 12, through: 1, by: -1)), id: \.self) { month in
            if let logs = monthlyLogs[month], !logs.isEmpty {
              Section(header: Text("\(month)월")) {
                ForEach(logs, id: \.self) { log in
                  LogCell(log: log)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing) {
                      Button(role: .destructive) {
                        dataManager.deleteLog(logID: log.id)
                        monthlyLogs[month]?.removeAll { $0.id == log.id }
                      } label: {
                        Label("삭제", systemImage: SystemNameKeys.trash)
                      }
                    }
                    .listRowInsets(.init(top: 5, leading: 15, bottom: 5, trailing: 15))
                }
              }
            }
          }
          
          Spacer(minLength: 100)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
          
        }
        .listStyle(.plain)
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          selectedYear -= 1
        } label: {
          Image(systemName: SystemNameKeys.chevronLeft)
        }
        .disabled(selectedYear <= 2000)
      }
      
      ToolbarItem(placement: .principal) {
        Text(String(selectedYear))
          .font(.title2.bold())
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          selectedYear += 1
        } label: {
          Image(systemName: SystemNameKeys.chevronRight)
        }
        .disabled(selectedYear >= Calendar.current.component(.year, from: Date()))
      }
    }
    .background(.appBackground)
    .onChange(of: selectedYear, { oldValue, newValue in
      monthlyLogs = getMonthlyLogs(year: selectedYear)
    })
    .onAppear {
      monthlyLogs = getMonthlyLogs(year: selectedYear)
    }
  }
}

extension YearlyLogsView {
  private func getMonthlyLogs(year: Int) -> [Int: [LogDomain]] {
    let logs = dataManager.sortByYear(yearOfInterest: year)
    var groupedLogs = Dictionary(grouping: logs, by: { log in
      Calendar.current.component(.month, from: log.date)
    })
    for (month, logs) in groupedLogs {
      groupedLogs[month] = logs.sorted(by: { $0.date > $1.date })
    }
    return groupedLogs
  }
}

extension YearlyLogsView {
  private func logCell(_ log: LogDomain) -> some View {
    VStack {
      HStack {
        // 앞 표시
        RoundedRectangle(cornerRadius: 8)
          .frame(width: 2.5, height: 35)
          .foregroundStyle(log.typeColor)
        
        Image(systemName: log.logType.image)
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .padding(5)
        
        // 상호+가격
        VStack(alignment: .leading) {
          Text(log.companyName)
            .font(.footnote)
          
          Text(log.subDescription)
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        
        Spacer()
        Text(DateHelper.shortFormat(date: log.date))
          .font(.caption)
      }
      .padding(.horizontal, 10)
      .frame(height: 60)
      .background(.cellBG)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .listRowBackground(Color.clear)
    }
  }
  
}
