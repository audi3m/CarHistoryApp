//
//  NewHistoryView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI

struct NewHistoryView: View {
    
    @State private var type = HistoryType.refuel
    @State private var date = Date.now
    @State private var content = ""
    @State private var cost = ""

    var body: some View {
        ScrollView {
            VStack {
                Image("car")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding()
                
                
                
                VStack {
                    DatePicker("날짜", selection: $date)
                }
                .padding()
                
                VStack {
                    Picker("타입", selection: $type) {
                        ForEach(HistoryType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    switch type {
                    case .refuel:
                        refuelContent()
                    case .maintenance:
                        maintenanceContent()
                    case .carWash:
                        carWashContent()
                    case .others:
                        othersContent()
                    }
                     
                }
                .padding()
                
                Button {
                    
                } label: {
                    Text("위치")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .padding()
            }
        }
    }
    
    private func refuelContent() -> some View {
        VStack {
            TextField("비용", text: $cost)
            TextField("가격", text: $cost)
            TextField("양", text: $cost)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical)
    }
    
    private func maintenanceContent() -> some View {
        VStack {
            TextField("비용", text: $cost)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical)
    }
    
    private func carWashContent() -> some View {
        VStack {
            TextField("비용", text: $cost)
            TextField("내용", text: $content, axis: .vertical)
                .lineLimit(5...)
                
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical)
    }
    
    private func othersContent() -> some View {
        VStack {
            TextField("비용", text: $cost)
        }
        .textFieldStyle(.roundedBorder)
        .padding(.vertical)
    }
}

extension NewHistoryView {
    enum HistoryType: String, CaseIterable {
        case refuel = "주유"
        case maintenance = "정비"
        case carWash = "세차"
        case others = "기타"
        
        var color: Color {
            switch self {
            case .refuel:
                return .red
            case .maintenance:
                return .green
            case .carWash:
                return .blue
            case .others:
                return .gray
            }
        }
    }
}

#Preview {
    NewHistoryView()
}
