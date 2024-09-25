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
    @State private var mileage = ""
    @State private var totalCost = ""
    @State private var price = ""
    @State private var refuelAmount = ""
    @State private var notes = ""
    @State private var coordinates = CLLocationCoordinate2D(latitude: 100, longitude: 40)
    
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
        history.mileage = mileage
        history.totalCost = totalCost
        history.price = price
        history.refuelAmount = refuelAmount
        history.notes = notes
        history.latitude = coordinates.latitude
        history.longitude = coordinates.longitude
        
        CarEnrollManager.shared.addNewHistory(history: history)
    }
}


// SubViews
extension NewHistorySheet {
    
    private func historyTypePickerSection() -> some View {
        
        Section {
            CustomTextField(image: "road.lanes", placeHolder: "Mileage", text: $totalCost)
            Picker("", systemImage: historyType.image, selection: $historyType) {
                ForEach(HistoryType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .foregroundStyle(.blackWhite.opacity(0.7))
            .tint(.blackWhite)
        }
    }
     
    private func contentSection() -> some View {
        Section {
            CustomTextField(image: "creditcard", placeHolder: "Cost", text: $totalCost)
            if historyType == .refuel {
                CustomTextField(image: "drop.halffull", placeHolder: "Amount", text: $refuelAmount)
            }
            if !(historyType == .refuel) {
                CustomTextField(image: "note.text", placeHolder: "Notes", axis: .vertical, keyboardType: .default, text: $notes)
                    .lineLimit(5...)
            }
        }
    }
    
    private func dateSection() -> some View {
        Section {
            DisclosureGroup(DateHelper.shared.shortFormat(date: date)) {
                DatePicker("날짜", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
        }
    }
    
    private func locationSection() -> some View {
        Section {
            NavigationLink {
                LocationSelectView(coordinates: $coordinates)
            } label: {
                Text("Location")
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
