//
//  LogViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/12/24.
//

import Foundation

final class LogViewModel: ObservableObject, LogRepository {
    
    private let logService: LogRepository
    
    @Published var logs = [LogDomain]()
    
    init(logService: LogRealmService) {
        self.logService = LogRealmService()
        
    }
    
//    var filteredLogs: RealmSwift.List<CarLog> {
//        let filteredList = RealmSwift.List<CarLog>()
//        let calendar = Calendar.current
//        let startOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 1, day: 1))!
//        let endOfYear = calendar.date(from: DateComponents(year: selectedYear, month: 12, day: 31))!
//        
//        for log in car.logList {
//            if log.date >= startOfYear && log.date <= endOfYear {
//                filteredList.append(log)
//            }
//        }
//        return filteredList
//    }
    
    
    
}

extension LogViewModel {
    
    @discardableResult
    func fetchLogs(carID: String) -> [LogDomain] {
        logs = logService.fetchLogs(carID: carID)
        return []
    }
    
    func createLog(log: LogDomain) {
        logs.append(log)
        logService.createLog(log: log)
    }
    
    func deleteLog(logID: String) {
        logs.removeAll { $0.id == logID }
        logService.deleteLog(logID: logID)
    }
    
    func updateLog(log: LogDomain) {
        
        logService.updateLog(log: log)
    }
}
