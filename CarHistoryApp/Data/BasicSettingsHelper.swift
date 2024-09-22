//
//  SettingsHelper.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

final class SettingsHelper {
    static let shared = SettingsHelper()
    private init() { }
    
    // 앱 처음 키고 등록한적없을 때
    var isFirstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isFirstLaunch")
        }
    }
    
    // 자동차
    var selectedCar: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "selectedCar")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedCar")
        }
    }
    
    // 라이트/다크
    var appearance: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "appearance")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "appearance")
        }
    }
    
    // 화폐, mile/km, l/g
    
    
    
    
    
    
    
}
