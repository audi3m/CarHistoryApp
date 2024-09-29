//
//  BasicSettingsHelper.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

final class BasicSettingsHelper {
    static let shared = BasicSettingsHelper()
    private init() { }
    
    // 앱 처음 키고 등록한적없을 때
    var isFirstLaunch: Bool {
        get {
            if UserDefaults.standard.object(forKey: "isFirstLaunch") == nil {
                return true
            }
            return UserDefaults.standard.bool(forKey: "isFirstLaunch")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isFirstLaunch")
        }
    }
    
    // 자동차
    var selectedCar: String {
        get {
            return UserDefaults.standard.string(forKey: "selectedCar") ?? ""
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
    
    // 0: km, 1: mile
    var distanceUnit: String {
        get {
            return UserDefaults.standard.string(forKey: "distanceUnit") ?? "km"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "distanceUnit")
        }
    }
    
    // 0: liter, 1: gallon
    var volumeUnit: String {
        get {
            return UserDefaults.standard.string(forKey: "volumeUnit") ?? "liter"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "volumeUnit")
        }
    }
    
}
