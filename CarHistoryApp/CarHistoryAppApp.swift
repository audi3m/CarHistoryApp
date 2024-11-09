//
//  CarHistoryAppApp.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import RealmSwift
import Firebase

@main
struct CarHistoryAppApp: App {
    @AppStorage("selectedAppearanceMode") private var selectedAppearanceMode: String = "system"
    
    init() {
        setupRealm()
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(colorScheme(for: selectedAppearanceMode))
            
        }
    }
    
    private func setupRealm() {
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
