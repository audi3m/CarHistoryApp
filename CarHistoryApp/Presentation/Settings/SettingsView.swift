//
//  SettingsView.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/3/24.
//

import SwiftUI

enum Appearance: String, CaseIterable {
    case system, light, dark
    
    var name: String {
        switch self {
        case .system:
            "시스템"
        case .light:
            "라이트"
        case .dark:
            "다크"
        }
    }
}

struct SettingsView: View {
    @AppStorage("selectedAppearanceMode") private var selectedAppearanceMode = "system"
    
    var body: some View {
        List {
            Section("화면 모드") {
                HStack {
                    ForEach(Appearance.allCases, id: \.self) { item in
                        
                        VStack(spacing: 8) {
                            Text(item.name)
                            Image(systemName: selectedAppearanceMode == item.rawValue ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .onTapGesture {
                            withAnimation {
                                selectedAppearanceMode = item.rawValue
                            }
                        }
                        
                        if item.rawValue != "dark" {
                            Divider()
                                .frame(width: 5)
                                .padding(.vertical, 12)
                        }
                    }
                }
            } 
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            
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
                    Text("1.0.6")
                }
            }
            
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
 
