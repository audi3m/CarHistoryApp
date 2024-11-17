//
//  BasicSettingsHelper.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import Foundation

enum BasicSettingsHelper {
    
    // 앱 처음 키고 등록한적없을 때
    static var isFirstLaunch: Bool {
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
    static var selectedCarNumber: String {
        get {
            return UserDefaults.standard.string(forKey: "selectedCarNumber") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedCarNumber")
        }
    }
    
    // 0: km, 1: mile
    static var distanceUnit: String {
        get {
            return UserDefaults.standard.string(forKey: "distanceUnit") ?? "km"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "distanceUnit")
        }
    }
    
    // 0: liter, 1: gallon
    static var volumeUnit: String {
        get {
            return UserDefaults.standard.string(forKey: "volumeUnit") ?? "liter"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "volumeUnit")
        }
    }
}
