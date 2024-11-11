//
//  LogRepositoryProtocol.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/10/24.
//

import Foundation
import RealmSwift

protocol LogRepositoryProtocol {
    func fetchLogs(carID: String) -> [LogDomain]
    func createLog(log: LogDomain)
    func deleteLog(logID: String)
    func updateLog(log: LogDomain)
}
