//
//  NewHistorySheet.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import SwiftUI
import CoreLocation

struct NewHistorySheet: View {
    @Environment(\.dismiss) private var dismiss
    
    let car: Car
    
    @State private var historyType = HistoryType.refuel
    @State private var date = Date()
    @State private var mileageKm = ""
    @State private var totalCost = ""
    @State private var price = ""
    @State private var refuelAmount = ""
    @State private var notes = ""
    @State private var coordinates: CLLocationCoordinate2D?
    
    var body: some View {
        NavigationStack {
            List {
                historyTypePickerSection()
                contentSection()
                dateSection()
                locationSection()
            }
            .navigationTitle("New History")
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
                        addNewHistory()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

// 함수
extension NewHistorySheet {
    private func addNewHistory() {
        let history = CarHistory()
        history.car = car
        history.historyType = historyType
        history.date = date
        history.mileage = mileageKm
        history.totalCost = totalCost
        history.price = price
        history.refuelAmount = refuelAmount
        history.notes = notes
        
        if let coordinates {
            history.latitude = coordinates.latitude
            history.longitude = coordinates.longitude
        }
        
        CarDataManager.shared.addNewHistory(history: history)
    }
}


// SubViews
extension NewHistorySheet {
    
    private func historyTypePickerSection() -> some View {
        
        Section {
            Picker("", systemImage: historyType.image, selection: $historyType) {
                ForEach(HistoryType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .foregroundStyle(.blackWhite.opacity(0.7))
            .tint(.blackWhite)
            
            HStack(spacing: 16) {
                Image(systemName: "road.lanes")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blackWhite.opacity(0.7))
                    .frame(width: 23, height: 23)
                
//                HStack {
//                    Text("12,120 km")
//                        .foregroundStyle(.secondary)
//                    Image(systemName: "chevron.right")
//                        .foregroundStyle(.secondary)
//                    TextField("Mileage", text: $mileage)
//                }
            }
            
            CustomTextField(image: "", placeHolder: "Current", text: $mileageKm)
            
//            CustomTextField(image: "road.lanes", placeHolder: "Mileage", text: $mileage)
            
        }
    }
     
    private func contentSection() -> some View {
        Section {
            CustomTextField(image: "creditcard.fill", placeHolder: "Cost", text: $totalCost)
            if historyType == .refuel {
                CustomTextField(image: "drop.halffull", placeHolder: "Amount", text: $refuelAmount)
            }
            if !(historyType == .refuel) {
                CustomTextField(image: "text.bubble", placeHolder: "Notes", axis: .vertical, keyboardType: .default, text: $notes)
                    .lineLimit(5...)
            }
        }
    }
    
    private func dateSection() -> some View {
        Section {
            DisclosureGroup(
                content: {
                    DatePicker("날짜", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }, label: {
                    HStack(spacing: 16) {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blackWhite.opacity(0.7))
                            .frame(width: 23, height: 23)
                        Text(DateHelper.shared.shortFormat(date: date))
                    }
                }
            )
        }
    }
    
    private func locationSection() -> some View {
        Section {
            NavigationLink {
                LocationSelectView(coordinates: $coordinates)
            } label: {
                HStack(spacing: 16) {
                    Image(systemName: "map")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.blackWhite.opacity(0.7))
                        .frame(width: 23, height: 23)
                    
                    Text("Location")
                }
            }
            
            if let _ = coordinates {
                Text("Location Selected")
            }
            
        }
    }
    
    private func imagePicker() -> some View {
        Image("car")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding()
        
    }
}

#Preview {
    NewHistorySheet(car: Car())
}
