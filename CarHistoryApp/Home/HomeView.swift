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
    
    let columns4 = Array(repeating: GridItem(.flexible()), count: 4)
    let columns3 = Array(repeating: GridItem(.flexible()), count: 3)
    
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
                ToolbarItem(placement: .topBarLeading) {
                    carSelector()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    side()
                }
            }
        }
        .onAppear {
            // 선택된 차로 설정
        }
        .sheet(isPresented: $showAddNewHistorySheet) {
            NewHistorySheet(car: selectedCar ?? Car())
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showAddNewCarSheet) {
            CarEnrollView()
                .interactiveDismissDisabled(true)
        }
        .onAppear {
            print("Home Appeared")
        }
    }
}

// Nav
extension HomeView {
    private func carSelector() -> some View {
        Menu {
            ForEach(CarRepository.shared.cars) { car in
                Button {
                    selectedCar = car
                } label: {
                    Text(car.plateNumber)
                }
            }
        } label: {
            HStack {
                Text(selectedCar?.plateNumber ?? "없음")
                    .font(.title2)
                    .bold()
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
            .foregroundStyle(.blackWhite)
        }
    }
    
    private func side() -> some View {
        Button {
            showAddNewCarSheet = true
        } label: {
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.blackWhite)
        }
    }
}

// Other Views
extension HomeView {
    private func addNewHistoryButton() -> some View {
        Button {
            showAddNewHistorySheet.toggle()
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
    
    private func carProfile() -> some View {
        VStack {
            Image("ferrari")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.horizontal)
        }
        .padding(.top, 30)
        .padding(.horizontal)
    }
    
    private func monthlySummary() -> some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("9 월 요약")
                    .font(.title3.bold())
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("전체")
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
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray.opacity(0.15))
                        )
                    }
                    
                }
            }
            
        }
        .padding()
    }
    
    private func nearby() -> some View {
        VStack(alignment: .leading) {
            Text("주변 검색")
                .font(.title3.bold())
                .padding(.leading, 6)
            
            LazyVGrid(columns: columns4) {
                ForEach(Nearby.allCases, id: \.self) { nearby in
                    NavigationLink {
                        NavigationLazyView(NearbyMapView(place: nearby.rawValue))
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: nearby.image)
                                .frame(height: 17)
                            Text(nearby.rawValue)
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.blackWhite)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(nearby.color)
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
                Text("최근")
                    .font(.title3.bold())
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("전체")
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
    
    private func grid() -> some View {
        VStack(alignment: .leading) {
            
            Text("섹션 제목")
                .font(.title3.bold())
                .padding(.leading, 4)
            
            LazyVGrid(columns: columns4) {
                ForEach(ShortcutLink.allCases, id: \.self) { link in
                    NavigationLink {
                        
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: link.image)
                            Text(link.rawValue)
                                .font(.caption)
                        }
                        .foregroundStyle(.blackWhite)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .padding()
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
