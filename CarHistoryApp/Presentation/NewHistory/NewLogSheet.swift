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
    
    @EnvironmentObject var dataManager: LocalDataManager
    @StateObject private var vm = NewLogViewModel()
    
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
                    .disabled(!vm.isValid)
                }
            }
        }
        .interactiveDismissDisabled(true)
        .onDisappear {
            vm.clearSubscription()
        }
    }
}

// 함수
extension NewLogSheet {
    private func addNewLog() {
        var newLog = vm.makeNewLog()
        dataManager.createLog(log: &newLog)
    }
     
}

// SubViews
extension NewLogSheet {
    
    private func commonSection() -> some View {
        Section {
            DisclosureGroup(
                content: {
                    DatePicker("날짜", selection: $vm.date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }, label: {
                    HStack(spacing: 16) {
                        Image(systemName: SystemNameKeys.calendar)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blackWhite.opacity(0.7))
                            .frame(width: 23, height: 23)
                        
                        Text(DateHelper.shortFormat(date: vm.date))
                    }
                }
            )
            
            HStack(spacing: 16) {
                Image(systemName: SystemNameKeys.roadLanes)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blackWhite.opacity(0.7))
                    .frame(width: 23, height: 23)
                
                HStack {
//                    Text(getLastMileage() + "km")
//                    
//                    Spacer(minLength: 10)
//                    
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.placeholder)
//                    
//                    Spacer(minLength: 10)
                    
                    TextField("[필수] 주행거리", text: $vm.mileage)
                        .keyboardType(.numberPad)
                }
                .minimumScaleFactor(0.8)
            }
        } footer: {
            if let message = vm.mileageErrorMessage {
                Text(message)
                    .foregroundStyle(.red)
            }
        }
    }
    
    private func companyNameSection() -> some View {
        Section {
            CustomTextField(image: SystemNameKeys.buildings, placeHolder: "상호명", keyboardType: .default, text: $vm.companyName)
        }
    }
    
    private func typeAndValueSection() -> some View {
        Section {
            Picker("", systemImage: vm.logType.image, selection: $vm.logType) {
                ForEach(LogTypeDomain.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .foregroundStyle(.blackWhite.opacity(0.7))
            .tint(.blackWhite)
            .onChange(of: vm.logType) { oldValue, newValue in
                vm.totalCost = ""
                vm.refuelInt = 30.0
                vm.refuelPoint = 0.0
                vm.notes = ""
            }
            
            CustomTextField(image: SystemNameKeys.creditcard, placeHolder: "[필수] 총 비용", text: $vm.totalCost)
            
            if vm.logType == .refuel {
                HStack {
                    Image(systemName: SystemNameKeys.fuelPump)
                    Spacer()
                    HStack(spacing: 0) {
                        Picker("주유량", selection: $vm.refuelInt) {
                            ForEach(Array(stride(from: 1.0, through: 200.0, by: 1)), id: \.self) { num in
                                Text("\(num, specifier: "%.f")")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100)
                        
                        Text(".")
                            .frame(width: 7)
                        
                        Picker("주유량", selection: $vm.refuelPoint) {
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
            } else {
                CustomTextField(image: SystemNameKeys.textBubble, placeHolder: "내용", axis: .vertical, keyboardType: .default, text: $vm.notes)
                    .lineLimit(5...)
            }
            
            if vm.logType == .refuel {
                PriceCell(price: vm.price)
            }
            
        } footer: {
//            Text("정확한 정보를 입력해주세요")
            if let message = vm.costErrorMessage {
                Text(message)
                    .foregroundStyle(.red)
            }
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
