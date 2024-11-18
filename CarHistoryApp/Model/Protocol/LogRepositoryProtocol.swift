//
//  LogRepositoryProtocol.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation

protocol LogRepository {
    func fetchLogs(carID: String) -> [LogDomain]
    func createLog(to carID: String, log: LogDomain) -> String
    func deleteLog(from carID: String, logID: String)
    func updateLog(log: LogDomain)
}
