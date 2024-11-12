//
//  LogViewModel.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/12/24.
//

import Foundation

final class LogViewModel: ObservableObject {
    
    private let service: LogRepository
    
    @Published var logs = [LogDomain]()
    
    init(service: LogRealmService, logs: [LogDomain] = [LogDomain]()) {
        self.service = LogRealmService()
        self.logs = logs
    }
    
    
    
    
    
    
}
