//
//  LogTestService.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/17/24.
//

import Foundation

final class LogTestService: LogRepository {
    // Test
    
}

extension LogTestService {
     
    func fetchLogs(carID: String) -> [LogDomain] {
        return []
    }
    
    func createLog(to car: String, log: LogDomain) -> String {
        return ""
    }
    
    func deleteLog(from: String, logID: String) {
        
    }
    
    func updateLog(log: LogDomain) {
        
    }
    
}
