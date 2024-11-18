//
//  RepositoryTestView.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/16/24.
//

import SwiftUI

struct RepositoryTestView: View {
    @EnvironmentObject var dataManager: AllDataManager
    
    @State private var showAddNewCarSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataManager.logs) { log in
                    Text("\(Int.random(in: 100...999))")
                    
//                    VStack {
//                        Text("\(log.totalCost)")
//                        Text(log.companyName)
//                        Text(log.date.description)
//                        Text(log.logType.rawValue)
//                    }
                }
            }
            .navigationTitle("Test")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    carSelector()
                }
            }
        }
        .onAppear {
            dataManager.fetchCars()
            if let car = dataManager.fetchSelectedCar() {
                dataManager.fetchLogs(carID: car.id)
            }
        }
    }
}

extension RepositoryTestView {
    @ViewBuilder
    private func carSelector() -> some View {
        if dataManager.cars.isEmpty {
            Button {
                showAddNewCarSheet = true
            } label: {
                HStack {
                    Text("차량 등록")
                    Image(systemName: "plus.circle")
                }
            }
        } else {
            Menu {
                Section {
                    ForEach(dataManager.cars) { car in
                        Button {
                            dataManager.selectCar(car: car)
                        } label: {
                            Text(car.plateNumber)
                            if let selectedCar = dataManager.fetchSelectedCar(), selectedCar == car {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                
                Section{
                    Button {
                        showAddNewCarSheet = true
                    } label: {
                        Label("추가하기", systemImage: "plus.circle")
                    }
                }
                
            } label: {
                HStack {
                    Text(dataManager.selectedCar?.plateNumber ?? "None")
                        .font(.title2)
                        .bold()
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .foregroundStyle(.blackWhite)
            }
        }
    }
}
