//
//  SettingsView2.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/3/24.
//

import SwiftUI
import RealmSwift

struct SettingsView2: View {
    
    var body: some View {
        List {
            
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
                    Text("1.0.3")
                }
            }
            
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView2()
}
