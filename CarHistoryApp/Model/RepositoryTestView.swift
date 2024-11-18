//
//  RepositoryTestView.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/16/24.
//

import SwiftUI

struct RepositoryTestView: View {
    @EnvironmentObject var dataManager: AllDataManager
    
    var body: some View {
        NavigationStack {
            List {
                if dataManager.logs.isEmpty {
                    Text("Empty")
                } else {
                    ForEach(dataManager.logs) { log in
                        VStack {
                            Text("\(log.totalCost)")
                            Text(log.companyName)
                            Text(log.date.description)
                            Text(log.logType.rawValue)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("삭제") {
                                dataManager.deleteLog(logID: log.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Test")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    carSelector()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    addButton()
                }
            }
        }
        .onAppear {
            dataManager.fetchAllCars()
            if let car = dataManager.fetchCar() {
                dataManager.fetchLogs(carID: car.id)
            }
        }
    }
}

extension RepositoryTestView {
    func addNewLog() {
        let newLog = LogDomain(companyName: "\(Int.random(in: 1000...9999))")
        dataManager.createLog(log: newLog)
    }
}

extension RepositoryTestView {
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            addNewLog()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    @ViewBuilder
    private func carSelector() -> some View {
        if dataManager.cars.isEmpty {
            Button {
                let car = CarDomain(manufacturer: "현대\(Int.random(in: 1...9))",
                                    plateNumber: "\(Int.random(in: 1000...9999))")
                dataManager.createCar(car: car)
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
                            if let selectedCar = dataManager.fetchCar(), selectedCar == car {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                
                Section{
                    Button {
                        let car = CarDomain(manufacturer: "현대\(Int.random(in: 1...9))",
                                            plateNumber: "\(Int.random(in: 1000...9999))")
                        dataManager.createCar(car: car)
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
