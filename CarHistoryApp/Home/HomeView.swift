//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @StateObject private var carManager = CarDataManager.shared
    
    @ObservedResults(Car.self) var cars
    @ObservedResults(CarLog.self) var allLogs
    
    var filteredLogs: Results<CarLog> {
        allLogs.where { $0.car == selectedCar }
    }
    
    @State private var isFirstAppear = true
    
    @State private var selectedCar: Car?
    @State private var showAddNewLogSheet = false
    @State private var showAddNewCarSheet = false
    
    @State private var noEnrolledCar = false
    
    let columns3 = Array(repeating: GridItem(.flexible()), count: 3)
    let columns4 = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                carProfile()
                monthlySummary()
                nearby()
                recent()
                    .padding(.bottom, 100)
            }
            .background(.appBackground)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottomTrailing) {
                addNewLogButton()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { carSelector() }
                ToolbarItem(placement: .topBarTrailing) { side() }
            }
        }
        .onAppear {
            if isFirstAppear { onAppearTask() }
        }
        .sheet(isPresented: $showAddNewLogSheet) {
            if let selectedCar {
                NewLogSheet(car: selectedCar)
            }
        }
        .sheet(isPresented: $showAddNewCarSheet) {
            CarEnrollView()
        }
        .alert("등록된 차량이 없습니다", isPresented: $noEnrolledCar) {
            Button("차량 등록하기") { showAddNewCarSheet = true }
        } message: {
            Text("차량을 등록한 후에 기록을 추가할 수 있습니다")
        }

    }
}

extension HomeView {
    private func onAppearTask() {
        let number = BasicSettingsHelper.shared.selectedCarNumber
        if number.isEmpty {
            selectedCar = cars.first
        } else {
            selectedCar = cars.first { $0.plateNumber == number }
        }
        CarDataManager.shared.printDirectory()
        
        isFirstAppear = false
    }
}

// Main Views
extension HomeView {
    private func monthlySummary() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(DateHelper.shared.currentMonthLong())
                    .font(.system(size: 19, weight: .bold))
                
                Spacer()
                
                NavigationLink {
                    SummaryView()
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .foregroundStyle(.blackWhite)
            }
            .padding(.horizontal, 6)
            
            LazyVGrid(columns: columns3) {
                ForEach(MonthlySummary.allCases, id: \.self) { summary in
                    VStack(spacing: 8) {
                        Image(systemName: summary.image)
                            .frame(height: 15)
                        Text(summary.value)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.8)
                    }
                    .foregroundStyle(.blackWhite)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.whiteBlack)
                            .shadow(color: .blackWhite.opacity(0.07), radius: 1, x: 2, y: 2)
                    )
                }
            }
        }
        .padding()
    }
    private func nearby() -> some View {
        VStack(alignment: .leading) {
            Text("Nearby")
                .font(.system(size: 19, weight: .bold))
                .padding(.horizontal, 6)
            
            LazyVGrid(columns: columns4) {
                ForEach(Nearby.allCases, id: \.self) { nearby in
                    NavigationLink {
                        NearbyMapView(nearby: nearby)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: nearby.image)
                                .frame(height: 17)
                                .foregroundStyle(nearby.color)
                            
                            Text(nearby.rawValue)
                                .foregroundStyle(.blackWhite)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.whiteBlack)
                                .shadow(color: .blackWhite.opacity(0.07), radius: 1, x: 2, y: 2)
                        )
                    }
                }
            }
        }
        .padding()
    }
    private func recent() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Recent")
                    .font(.system(size: 19, weight: .bold))
                
                Spacer()
                
                NavigationLink {
                    if let selectedCar {
                        YearlyLogView(car: selectedCar)
                    }
                } label: {
                    Text("All")
                        .font(.footnote)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .foregroundStyle(.blackWhite)
            }
            .padding(.horizontal, 6)
            
            VStack {
                ForEach(filteredLogs.prefix(5)) { log in
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 2.5, height: 35)
                            .foregroundStyle(log.typeColor)
                        
                        Image(systemName: log.logType.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(5)
                        
                        VStack(alignment: .leading) {
                            Text(log.companyName)
                                .font(.footnote)
                            
                            Text(log.subDescription)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        Text(DateHelper.shared.shortFormat(date: log.date))
                            .font(.caption)
                    }
                    .padding(10)
                    .padding(.vertical, 5)
                    .frame(height: 60)
                    .background(Color.whiteBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
    }
    private func carProfile() -> some View {
        VStack {
            if let selectedCar {
                if let image = CarImageManager.shared.loadImageToDocument(filename: "\(selectedCar.id)") {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(height: 150)
                        
                        Ellipse()
                            .fill(EllipticalGradient(colors: [.blackWhite.opacity(0.5), .clear]))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .padding(.bottom, 10)
                            .zIndex(-1000)
                    }
                    
                } else {
                    Image(systemName: "car.side")
                        .resizable()
                        .fontWeight(.ultraLight)
                        .scaledToFit()
                        .frame(height: 120)
                        .padding(15)
                }
            } else {
                Image(systemName: "car.side")
                    .resizable()
                    .fontWeight(.ultraLight)
                    .scaledToFit()
                    .frame(height: 120)
                    .padding(15)
            }
        }
        .padding(.top, 30)
        .padding(.horizontal)
    }
}

// Navigation Bar
extension HomeView {
    @ViewBuilder
    private func carSelector() -> some View {
        if cars.isEmpty {
            Button {
                showAddNewCarSheet = true
            } label: {
                HStack {
                    Text("Car Enroll")
                    Image(systemName: "plus.circle")
                }
            }
        } else {
            Menu {
                ForEach(cars) { car in
                    Button {
                        selectedCar = car
                        BasicSettingsHelper.shared.selectedCarNumber = car.plateNumber
                    } label: {
                        Text(car.plateNumber)
                        if BasicSettingsHelper.shared.selectedCarNumber == car.plateNumber {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selectedCar?.plateNumber ?? "None")
                        .font(.title2)
                        .bold()
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .foregroundStyle(.blackWhite)
            }
        }
    }
    
    private func side() -> some View {
        Button {
            showAddNewCarSheet = true
        } label: {
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.blackWhite)
                .scaleEffect(y: 1.3)
        }
    }
}

// Plus Button
extension HomeView {
    private func addNewLogButton() -> some View {
        Button {
            if selectedCar != nil {
                showAddNewLogSheet = true
            } else {
                noEnrolledCar = true
            }
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.white, .blue)
        }
        .contentShape(Circle())
        .padding()
    }
}

#Preview {
    HomeView()
}
