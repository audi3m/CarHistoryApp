//
//  SettingsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI

enum SideMenu: String, CaseIterable {
    case newCar = "차량 등록"
    case settings = "설정"
    
    var icon: String {
        switch self {
        case .newCar:
            "plus.circle"
        case .settings:
            "gearshape"
        }
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var distance = DistanceUnit.kilometer
    @State private var volume = VolumeUnit.liter
    @State private var language = Language.english
    
    var body: some View {
        NavigationStack {
            List {
                Text("화폐 단위")
                
                Picker("언어", selection: $language) {
                    ForEach(Language.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .tint(.blackWhite)
                .pickerStyle(.menu)
                
                Picker("거리", selection: $distance) {
                    ForEach(DistanceUnit.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                Picker("양", selection: $volume) {
                    ForEach(VolumeUnit.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
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
