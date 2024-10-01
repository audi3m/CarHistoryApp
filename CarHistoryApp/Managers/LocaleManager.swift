//
//  LocaleManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/29/24.
//

import Foundation

struct CurrencyInfo {
    let code: String
    let symbol: String
    
    init() {
        let locale = Locale.current
        self.code = locale.currency?.identifier ?? "N/A"
        self.symbol = locale.currencySymbol ?? "N/A"
    }
}
