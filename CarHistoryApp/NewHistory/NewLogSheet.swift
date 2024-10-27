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
                    Button("취소") { dismiss() }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        addNewLog()
                        dismiss()
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
                        
                        Text(DateHelper.shortFormat(date: logValidator.date))
                    }
                }
            )
            
            HStack(spacing: 16) {
                Image(systemName: "road.lanes")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blackWhite.opacity(0.7))
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
                logValidator.refuelInt = 30.0
                logValidator.refuelPoint = 0.0
                logValidator.notes = ""
            }
            
            CustomTextField(image: "creditcard.fill", placeHolder: "총 비용", text: $logValidator.totalCost)
            
            if logValidator.logType == .refuel {
                HStack {
                    Image(systemName: "fuelpump")
                    Spacer()
                    HStack(spacing: 0) {
                        Picker("주유량", selection: $logValidator.refuelInt) {
                            ForEach(Array(stride(from: 0.0, through: 200.0, by: 1)), id: \.self) { num in
                                Text("\(num, specifier: "%.f")")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Text(".")
                            .frame(width: 7)
                        
                        Picker("주유량", selection: $logValidator.refuelPoint) {
                            ForEach(Array(stride(from: 0.0, through: 9.0, by: 1)), id: \.self) { num in
                                Text("\(num, specifier: "%.f")")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 70)
                    }
                    Text("L")
                }
                .frame(height: 100)
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
