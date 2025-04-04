//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
  @EnvironmentObject var dataManager: LocalDataManager
  @StateObject var vm: HomeViewModel
  
  @State private var showAddNewLogSheet = false
  @State private var showAddNewCarSheet = false
  @State private var noEnrolledCar = false
  
  let columns4 = Array(repeating: GridItem(.flexible()), count: 4)
  
  init(dataManager: LocalDataManager) {
    _vm = StateObject(wrappedValue: HomeViewModel(dataManager: dataManager))
    print("init HomeView")
  }
  
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
      .navigationDestination(for: NearbyEnum.self) { nearby in
        NearbyMapView(nearby: nearby)
      }
      .navigationDestination(for: CarDomain.self) { car in
        YearlyLogsView()
      }
      .navigationDestination(for: String.self) { _ in
        SettingsView()
      }
    }
    .sheet(isPresented: $showAddNewLogSheet) {
      if dataManager.selectedCar != nil {
        NewLogSheet()
      }
    }
    .sheet(isPresented: $showAddNewCarSheet) {
      CarEnrollView()
    }
    .alert("등록된 차량이 없습니다", isPresented: $noEnrolledCar) {
      Button("차량 등록") { showAddNewCarSheet = true }
      Button("닫기", role: .cancel) { }
    } message: {
      Text("차량을 등록한 후에 기록을 추가할 수 있습니다")
    }
  }
  
}

// Summary Section
extension HomeView {
  
  private func getMileage() { }
  
}

// Main Views
extension HomeView {
  private func monthlySummary() -> some View {
    VStack(alignment: .leading) {
      
      HStack(spacing: 10) {
        Image(systemName: SystemNameKeys.gauge)
          .font(.title2)
        Text(DateHelper.currentMonthLong())
          .font(.system(size: 18, weight: .bold))
        
        Spacer()
        
        NavigationLink {
          LogChartView(dataManager: dataManager)
        } label: {
          Image(systemName: SystemNameKeys.chart)
          Image(systemName: SystemNameKeys.chevronRight)
            .font(.footnote)
        }
        .foregroundStyle(.blackWhite)
      }
      .padding(.horizontal, 6)
      
      HStack {
        Group {
          VStack(spacing: 8) {
            Image(systemName: SystemNameKeys.fuelPumpFill)
              .frame(height: 15)
            
            Text(vm.fuelExpense)
              .font(.footnote)
              .fontWeight(.semibold)
              .minimumScaleFactor(0.8)
          }
          
          VStack(spacing: 8) {
            Image(systemName: SystemNameKeys.bubble)
              .frame(height: 15)
            
            Text(vm.lastWash)
              .font(.footnote)
              .fontWeight(.semibold)
              .minimumScaleFactor(0.8)
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
        ForEach(NearbyEnum.allCases, id: \.self) { nearby in
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
        NavigationLink{
          YearlyLogsView()
        } label: {
          HStack {
            Text("All")
              .font(.footnote)
            Image(systemName: SystemNameKeys.chevronRight)
              .font(.footnote)
          }
          .foregroundStyle(.blackWhite)
        }
      }
      .padding(.horizontal, 6)
      
      VStack {
        if vm.recentFiveLogs.isEmpty {
          HStack {
            Text("기록 없음")
              .foregroundStyle(.placeholder)
          }
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          .background(Color.whiteBlack)
          .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        
        ForEach(vm.recentFiveLogs) { log in
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
      if let currentCar = dataManager.selectedCar,
         let image = CarImageManager.loadImageToDocument(filename: "\(currentCar.id)") {
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
        Image(systemName: SystemNameKeys.car)
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
    if dataManager.cars.isEmpty {
      Button {
        showAddNewCarSheet = true
      } label: {
        HStack {
          Text("차량 등록")
          Image(systemName: SystemNameKeys.plusCircle)
        }
      }
    } else {
      Menu {
        Section {
          ForEach(dataManager.cars) { car in
            Button {
              vm.selectCar(car: car)
            } label: {
              Text(car.plateNumber)
              if let currentCar = vm.selectedCar, currentCar == car {
                Image(systemName: SystemNameKeys.checkmark)
              }
            }
          }
        }
        
        Section{
          Button {
            showAddNewCarSheet = true
          } label: {
            Label("추가하기", systemImage: SystemNameKeys.plusCircle)
          }
        }
        
      } label: {
        HStack {
          Text(dataManager.selectedCar?.plateNumber ?? "None")
            .font(.title2)
            .bold()
          Image(systemName: SystemNameKeys.chevronDown)
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
      Image(systemName: SystemNameKeys.line3)
        .foregroundStyle(.blackWhite)
        .scaleEffect(y: 1.3)
    }
  }
  
}

// Plus Button
extension HomeView {
  private func addNewLogButton() -> some View {
    Button {
      if vm.selectedCar != nil {
        showAddNewLogSheet = true
      } else {
        noEnrolledCar = true
      }
    } label: {
      Image(systemName: SystemNameKeys.plusCircleFill)
        .font(.system(size: 50))
        .foregroundStyle(.white, .blue)
    }
    .contentShape(Circle())
    .shadow(radius: 3)
    .padding()
  }
}
