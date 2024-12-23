//
//  CarHistoryAppApp.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import RealmSwift

@main
struct CarHistoryAppApp: App {
    @AppStorage("selectedAppearanceMode") private var selectedAppearanceMode: String = "system"
    @StateObject private var dataManager = LocalDataManager(carService: CarRealmService(),
                                                            logService: LogRealmService())
    
    init() {
        configureRealm()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(dataManager: dataManager)
                .environmentObject(dataManager)
                .preferredColorScheme(colorScheme(for: selectedAppearanceMode))
            
        }
    }
    
    private func configureRealm() {
        let config = Realm.Configuration(schemaVersion: 0, migrationBlock: { migration, oldSchemaVersion in
            
//            if oldSchemaVersion < 1 {
//                
//            }
            
        })
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    private func colorScheme(for mode: String) -> ColorScheme? {
        switch mode {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil // 시스템 설정 따르기
        }
    }
}
