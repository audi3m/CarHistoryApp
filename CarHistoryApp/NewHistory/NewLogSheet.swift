//
//  NewLogSheet.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import SwiftUI
import CoreLocation
import RealmSwift

struct NewLogSheet: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var logValidator = LogValidator()
    
    @ObservedRealmObject var car: Car
    
    var body: some View {
        NavigationStack {
            List {
                commonSection()
                companyNameSection()
                typeAndValueSection()
            }
            .navigationTitle("새 기록")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewLog() 
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                    .disabled(!logValidator.isValid)
                }
            }
        }
        .interactiveDismissDisabled(true)
    }
}

// 함수
extension NewLogSheet {
    private func addNewLog() {
        let newLog = logValidator.makeNewLog()
        $car.logList.append(newLog)
    }
    
    private func getLastMileage() -> String {
        if let log = car.logList.last {
            return "\(log.mileage)"
        } else {
            return "0"
        }
        
    }
}

// SubViews
extension NewLogSheet {
    
    private func commonSection() -> some View {
        Section {
            DisclosureGroup(
                content: {
                    DatePicker("날짜", selection: $logValidator.date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }, label: {
                    HStack(spacing: 16) {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blackWhite.opacity(0.7))
                            .frame(width: 23, height: 23)
                        Text(DateHelper.shared.shortFormat(date: logValidator.date))
                    }
                }
            )
            
            HStack(spacing: 16) {
                Image(systemName: "road.lanes")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black.opacity(0.7))
                    .frame(width: 23, height: 23)
                
                HStack {
                    Text(getLastMileage() + "km")
                    
                    Spacer(minLength: 10)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.placeholder)
                    
                    Spacer(minLength: 10)
                    
                    TextField("주행거리", text: $logValidator.mileage)
                        .keyboardType(.numberPad)
                }
                .minimumScaleFactor(0.8)
            }
        }
    }
    
    private func companyNameSection() -> some View {
        Section {
            CustomTextField(image: "building.2.fill", placeHolder: "상호명", keyboardType: .default, text: $logValidator.companyName)
        }
    }
    
    private func typeAndValueSection() -> some View {
        Section {
            Picker("", systemImage: logValidator.logType.image, selection: $logValidator.logType) {
                ForEach(LogType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .foregroundStyle(.blackWhite.opacity(0.7))
            .tint(.blackWhite)
            .onChange(of: logValidator.logType) { oldValue, newValue in
                logValidator.totalCost = ""
                logValidator.refuelAmount = 30
                logValidator.notes = ""
            }
            
            CustomTextField(image: "creditcard.fill", placeHolder: "총 비용", text: $logValidator.totalCost)
            
            if logValidator.logType == .refuel {
                HStack {
                    Image(systemName: "fuelpump")
                    Picker("주유량", selection: $logValidator.refuelAmount) {
                        ForEach(Array(stride(from: 0.0, through: 200.0, by: 0.5)), id: \.self) { num in
                            Text("\(num, specifier: "%.1f")")
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("L")
                }
                .frame(height: 120)
//                CustomTextField(image: "drop.halffull", placeHolder: "주유/충전량", text: $logValidator.refuelAmount)
            }
            
            if !(logValidator.logType == .refuel) {
                CustomTextField(image: "text.bubble", placeHolder: "내용", axis: .vertical, keyboardType: .default, text: $logValidator.notes)
                    .lineLimit(5...)
            }
            
        } footer: {
            Text("정확한 정보를 입력해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    //    private func locationSection() -> some View {
    //        Section {
    //            NavigationLink {
    //                LocationSelectView(coordinates: $logValidator.coordinates)
    //            } label: {
    //                HStack(spacing: 16) {
    //                    Image(systemName: "map")
    //                        .resizable()
    //                        .scaledToFit()
    //                        .foregroundStyle(.blackWhite.opacity(0.7))
    //                        .frame(width: 23, height: 23)
    //
    //                    Text("Location")
    //                }
    //            }
    //
    //            if logValidator.coordinates != nil {
    //                Text("Location Selected")
    //            }
    //
    //        }
    //    }
    
    
}
