//
//  RepositoryTestView.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/16/24.
//

import SwiftUI

struct RepositoryTestView: View {
    @EnvironmentObject var dataManager: LocalDataManager
    
    var body: some View {
        NavigationStack {
            List {
                if dataManager.logs.isEmpty {
                    Text("Empty")
                } else {
                    ForEach(dataManager.logs) { log in
                        VStack(alignment: .leading) {
                            Text(log.companyName)
                            Text("\(log.date, style: .date)")
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    carList()
                }
            }
        }
    }
}

extension RepositoryTestView {
    func addNewLog() {
        var newLog = LogDomain(companyName: "\(Int.random(in: 1000...9999))")
        dataManager.createLog(log: &newLog)
    }
    
    func addNewCar() {
        var car = CarDomain(manufacturer: "현대\(Int.random(in: 1...9))",
                            plateNumber: "\(Int.random(in: 1000...9999))")
        dataManager.createCar(car: &car)
    }
}

extension RepositoryTestView {
    
    @ViewBuilder
    private func carList() -> some View {
        NavigationLink {
            TestCarListView()
        } label: {
            Image(systemName: "line.3.horizontal")
                .scaleEffect(x: 0.8, y: 1.2)
        }
    }
    
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
                addNewCar()
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
                            dataManager.setRecentCar(car: car)
                        } label: {
                            Text(car.plateNumber)
                            if let currentCar = dataManager.selectedCar, currentCar == car {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                
                Section{
                    Button {
                        addNewCar()
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
