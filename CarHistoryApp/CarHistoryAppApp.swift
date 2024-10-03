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
    
    init() {
        setupRealm()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
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
}
