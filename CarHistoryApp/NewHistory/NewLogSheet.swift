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
    
    let car: Car
    
    var body: some View {
        NavigationStack {
            List {
                commonSection()
                companyNameSection()
                typeAndValueSection()
            }
            .navigationTitle("New Log")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.immediately)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addNewLog()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(logValidator.isValid)
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
                    Text("0 km")
                    
                    Spacer(minLength: 10)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.placeholder)
                    
                    Spacer(minLength: 10)
                    
                    TextField("Mileage", text: $logValidator.mileage)
                        .keyboardType(.decimalPad)
                }
                .minimumScaleFactor(0.8)
            }
        }
    }
    
    private func companyNameSection() -> some View {
        Section {
            CustomTextField(image: "building.2.fill", placeHolder: "Company Name", keyboardType: .default, text: $logValidator.companyName)
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
            
            CustomTextField(image: "creditcard.fill", placeHolder: "Cost", text: $logValidator.totalCost)
            
            if logValidator.logType == .refuel {
                CustomTextField(image: "drop.halffull", placeHolder: "Amount", text: $logValidator.refuelAmount)
            }
            
            if !(logValidator.logType == .refuel) {
                CustomTextField(image: "text.bubble", placeHolder: "Notes", axis: .vertical, keyboardType: .default, text: $logValidator.notes)
                    .lineLimit(5...)
            }
        } footer: {
            Text("Enter Accurate Information To Get Meaningful Results")
                .frame(maxWidth: .infinity, alignment: .trailing)
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
