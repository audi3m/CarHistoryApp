//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    @ObservedResults(Car.self) var cars
    @State private var filteredLogs = RealmSwift.List<CarLog>()
    
    @State private var addedCar: Car?
    
    @State private var selectedCar: Car?
//    @ObservedRealmObject var selectedCar: Car?
    
    @State private var showAddNewLogSheet = false
    @State private var showAddNewCarSheet = false
    
    @State private var noEnrolledCar = false
    
    let columns2 = Array(repeating: GridItem(.flexible()), count: 2)
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
                ToolbarItem(placement: .topBarTrailing) { goToSettingsButton() }
            }
            .navigationDestination(for: Nearby.self) { nearby in
                NearbyMapView(nearby: nearby)
            }
            .navigationDestination(for: Car.self) { car in
                YearlyLogView(car: car)
            }
        }
        .onChange(of: selectedCar) {
            BasicSettingsHelper.selectedCarNumber = selectedCar?.plateNumber ?? ""
            fetchLogs()
        }
        .onChange(of: cars) {
            if let car = selectedCar {
                selectedCar = cars.first { $0.id == car.id } ?? cars.first
            } else {
                selectedCar = cars.first
            }
        }
        .onAppear {
            let plateNumber = BasicSettingsHelper.selectedCarNumber
            if let car = cars.first(where: { $0.plateNumber == plateNumber }) {
                selectedCar = car
                fetchLogs()
            }
        }
        .sheet(isPresented: $showAddNewLogSheet) {
            if let selectedCar {
                NewLogSheet(car: selectedCar)
                    .onDisappear {
                        fetchLogs()
                    }
            }
        }
        .sheet(isPresented: $showAddNewCarSheet) {
            CarEnrollView(addedCar: $addedCar)
                .onDisappear {
                    if let addedCar {
                        selectedCar = addedCar
                    }
                }
        }
        .alert("등록된 차량이 없습니다", isPresented: $noEnrolledCar) {
            Button("차량 등록") { showAddNewCarSheet = true }
            Button("닫기", role: .cancel) { }
        } message: {
            Text("차량을 등록한 후에 기록을 추가할 수 있습니다")
        }
        
    }
    
    private func fetchLogs() {
        guard let selectedCar else { return }
        let sortedLogs = RealmSwift.List<CarLog>()
        let sortedArray = selectedCar.logList.sorted(byKeyPath: "date", ascending: false)
        for log in sortedArray {
            sortedLogs.append(log)
        }
        filteredLogs = sortedLogs
    }
    
}

// Summary Section
extension HomeView {
    
    private func getMileage() { }
    
    private func getFuelExpense() -> some View {
        guard let selectedCar else {
            return Text("₩0")
                .font(.footnote)
                .foregroundStyle(.placeholder)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.8)
        }
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        
        let refuelList = selectedCar.logList
            .filter { $0.logType == .refuel }
            .filter {
                let logYear = calendar.component(.year, from: $0.date)
                let logMonth = calendar.component(.month, from: $0.date)
                return logYear == currentYear && logMonth == currentMonth
            }
        
        let totalCost = refuelList.reduce(0) { $0 + $1.totalCost }
        
        return Text("₩\(Int(totalCost))")
            .font(.footnote)
            .fontWeight(.semibold)
            .minimumScaleFactor(0.8)
    }
    
    //    private func getLatestWashThisMonth() {
    //        if let selectedCar, let wash = selectedCar.logList.last(where: { $0.logType == .carWash }) {
    //            monthlyMileage = wash.date.toSep30()
    //        } else {
    //            monthlyMileage = nil
    //        }
    //    }
    
    private func getLatestWash() -> some View {
        if let selectedCar, let wash = selectedCar.logList.last(where: { $0.logType == .carWash }) {
            Text(wash.date.toSep30())
                .font(.footnote)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.8)
        } else {
            Text("기록 없음")
                .font(.footnote)
                .foregroundStyle(.placeholder)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.8)
        }
    }
}

// Main Views
extension HomeView {
    private func monthlySummary() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Image(systemName: "gauge.open.with.lines.needle.33percent")
                    .font(.title2)
                Text(DateHelper.currentMonthLong())
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                //                NavigationLink {
                //                    SummaryView()
                //                } label: {
                //                    Image(systemName: "chart.bar.xaxis")
                //                    Image(systemName: "chevron.right")
                //                        .font(.footnote)
                //                }
                //                .foregroundStyle(.blackWhite)
            }
            .padding(.horizontal, 6)
            
            LazyVGrid(columns: columns2) {
                ForEach(MonthlySummary.allCases, id: \.self) { summary in
                    VStack(spacing: 8) {
                        Image(systemName: summary.image)
                            .frame(height: 15)
                        
                        switch summary {
//                        case .mileage:
//                            getMileage()
                        case .fuelCost:
                            getFuelExpense()
                        case .carWash:
                            getLatestWash()
                        }
                    }
                    .foregroundStyle(.blackWhite)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.cellBG)
                            .shadow(color: .blackWhite.opacity(0.07), radius: 1, x: 2, y: 2)
                    )
                }
            }
        }
        .padding()
    }
    private func nearby() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Text("주변 검색")
                    .font(.system(size: 18, weight: .bold))
            }
            .padding(.horizontal, 6)
            
            LazyVGrid(columns: columns4) {
                ForEach(Nearby.allCases, id: \.self) { nearby in
                    NavigationLink(value: nearby) {
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
                                .fill(.cellBG)
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
                Text("최근 기록")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                if let selectedCar {
                    NavigationLink(value: selectedCar) {
                        HStack {
                            Text("All")
                                .font(.footnote)
                            Image(systemName: "chevron.right")
                                .font(.footnote)
                        }
                        .foregroundStyle(.blackWhite)
                    }
                }
            }
            .padding(.horizontal, 6)
            
            VStack {
                if filteredLogs.isEmpty {
                    HStack {
                        Text("기록 없음")
                            .foregroundStyle(.placeholder)
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.whiteBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
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
                        Text(DateHelper.shortFormat(date: log.date))
                            .font(.caption)
                    }
                    .padding(10)
                    .padding(.vertical, 5)
                    .frame(height: 60)
                    .background(.cellBG)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding()
    }
    private func carProfile() -> some View {
        VStack {
            if let selectedCar, let image = CarImageManager.loadImageToDocument(filename: "\(selectedCar.id)") {
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
                    Text("차량 등록")
                    Image(systemName: "plus.circle")
                }
            }
        } else {
            Menu {
                Section {
                    ForEach(cars) { car in
                        Button {
                            selectedCar = car
                            fetchLogs()
                        } label: {
                            Text(car.plateNumber)
                            if let selectedCar, selectedCar == car {
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
    
    private func goToSettingsButton() -> some View {
        NavigationLink {
            SettingsView()
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
 
