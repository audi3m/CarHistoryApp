//
//  SettingsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/3/24.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    @AppStorage("selectedAppearanceMode") private var selectedAppearanceMode: String = "system"
    
    var body: some View {
        List {
            Section {
                Picker("Appearance Mode", selection: $selectedAppearanceMode) {
                    Text("시스템").tag("system")
                    Text("라이트").tag("light")
                    Text("다크").tag("dark")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
//            .listRowBackground(Color.clear)
//            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Section {
                NavigationLink {
                    CarManageView()
                } label: {
                    Text("차량관리")
                        .foregroundStyle(.blackWhite)
                }
            }
            
            Section {
                HStack {
                    Text("버전정보")
                    Spacer()
                    Text("1.0.4")
                }
            }
            
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
 
