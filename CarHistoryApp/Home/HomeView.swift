//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedCar: Car?
    @State private var showAddNewHistorySheet = false
    @State private var showAddNewCarSheet = false
    
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
                addNewHistoryButton()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { carSelector() }
                ToolbarItem(placement: .topBarTrailing) { side() }
            }
        }
        .onAppear {
            // 선택된 차로 설정
            selectedCar = CarEnrollManager.shared.cars.first
            CarEnrollManager.shared.printDirectory()
            
        }
        .sheet(isPresented: $showAddNewHistorySheet) {
            if let selectedCar {
                NewHistorySheet(car: selectedCar)
                    .interactiveDismissDisabled(true)
            }
        }
        .sheet(isPresented: $showAddNewCarSheet) {
            CarEnrollView()
                .interactiveDismissDisabled(true)
        }
    }
}

// Nav
extension HomeView {
    @ViewBuilder
    private func carSelector() -> some View {
        if CarEnrollManager.shared.cars.isEmpty {
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
                ForEach(CarEnrollManager.shared.cars) { car in
                    Button {
                        selectedCar = car
                    } label: {
                        Text(car.plateNumber)
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

// Other Views
extension HomeView {
    private func addNewHistoryButton() -> some View {
        Button {
            if selectedCar != nil {
                showAddNewHistorySheet = true
            }
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.white, .blue)
        }
        .padding()
        .contentShape(Circle())
    }
}

// Main Views
extension HomeView {
    
    private func monthlySummary() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Sep. Summary")
                    .font(.system(size: 19, weight: .bold))
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    Text("All")
                        .font(.footnote)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .foregroundStyle(.blackWhite)
            }
            .padding(.horizontal, 6)
            
            LazyVGrid(columns: columns3) {
                ForEach(MonthlySummary.allCases, id: \.self) { summary in
                    NavigationLink {
                        NavigationLazyView(summary.navigationLink)
                    } label: {
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
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 2, y: 2)
                        )
                    }
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
                        NavigationLazyView(NearbyMapView(place: nearby.query))
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
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 2, y: 2)
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
                
                Button {
                    
                } label: {
                    Text("All")
                        .font(.footnote)
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                }
                .foregroundStyle(.blackWhite)
            }
            .padding(.horizontal, 6)
            
            ForEach(DummyData.recent.prefix(5)) { recent in
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 3, height: 35)
                        .foregroundStyle(recent.color)

                    Image(systemName: recent.image)
                        .padding(.horizontal, 2)
                    
                    VStack(alignment: .leading) {
                        Text(recent.description)
                            .font(.footnote)
                        Text(recent.subDesc)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    Text(recent.date)
                        .font(.caption)
                }
                .padding(10)
                .padding(.vertical, 5)
                .frame(height: 60)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
    }
    
    private func carProfile() -> some View {
        VStack {
            if let selectedCar {
                if let image = CarEnrollManager.shared.loadImageToDocument(filename: "\(selectedCar.id)") {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(height: 150)
                        .padding(.horizontal)
                } else {
                    Image(systemName: "car.side")
                        .resizable()
                        .fontWeight(.thin)
                        .scaledToFit()
                        .frame(height: 120)
                }
            }
        }
        .padding(.top, 30)
        .padding(.horizontal)
    }
     
}

extension HomeView {
    enum CarSelection: String, CaseIterable {
        case first = "123주1234"
        case second = "26나5566"
        case third = "111가1234"
    }
}

#Preview {
    HomeView()
}
