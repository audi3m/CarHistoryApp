//
//  SettingsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var distance = DistanceUnit.kilometer
    @State private var volume = VolumeUnit.liter
    @State private var language = Language.english
    
    var body: some View {
        List {
            Text("화폐 단위")
            
            Picker("언어", selection: $language) {
                ForEach(Language.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.menu)
            
            Picker("거리", selection: $distance) {
                ForEach(DistanceUnit.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.menu)
            
            Picker("양", selection: $volume) {
                ForEach(VolumeUnit.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.menu)
            
            
        }
    }
}

extension SettingsView {
    
    enum DistanceUnit: String, CaseIterable {
        case kilometer = "km"
        case mile = "mile"
    }
    
    enum VolumeUnit: String, CaseIterable {
        case liter = "L"
        case gallon = "gallon"
    }
    
    enum Language: String, CaseIterable {
        case english = "English"
        case korean = "한국어"
        case japanese = "日本語"
    }
}

#Preview {
    SettingsView()
}
