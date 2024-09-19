//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var car = CarSelection.first
    @State private var showAddNewSheet = false
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                summary()
                thisMonth()
                grid()
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
        .fullScreenCover(isPresented: $showAddNewSheet) {
            NewHistorySheet()
        }
    }
}

// Nav
extension HomeView {
    private func carSelector() -> some View {
        Menu {
            ForEach(CarSelection.allCases, id: \.self) { option in
                Button {
                    car = option
                } label: {
                    Text(option.rawValue)
                }
            }
        } label: {
            HStack {
                Text(car.rawValue)
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
            showAddNewSheet.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.whiteBlack, .blue)
        }
        .padding()
        .contentShape(Circle())
    }
}

// Main Views
extension HomeView {
    
    private func thisMonth() -> some View {
        VStack(alignment: .leading) {
            
            Text("이번 달")
                .font(.title3)
                .bold()
            
            HStack {
                ForEach(MonthlySummary.allCases, id: \.self) { summary in
                    NavigationLink {
                        
                    } label: {
                        VStack(spacing: 4) {
                            Text(summary.value)
                            Text(summary.rawValue)
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
    
    private func grid() -> some View {
        VStack(alignment: .leading) {
            
            Text("섹션 제목")
                .font(.title3)
                .bold()
            
            LazyVGrid(columns: columns) {
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
    
    private func summary() -> some View {
        VStack {
            Image("tesla")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 120)
                .padding(.vertical, 30) 
            
            HStack {
                Text("123주1234")
                Text("12,463km")
            }
        }
        .padding()
    }
    
    private func nearby() -> some View {
        VStack(alignment: .leading) {
            Text("주변 검색")
                .font(.title3)
                .bold()
            
            HStack {
                ForEach(Nearby.allCases, id: \.self) { nearby in
                    NavigationLink {
                        
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: nearby.image)
                            Text(nearby.rawValue)
                                .font(.caption)
                        }
                        .foregroundStyle(.blackWhite)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(nearby.color)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                }
            }
        }
        .padding()
    }
    
    private func recent() -> some View {
        VStack(alignment: .leading) {
            
            Text("최근")
                .font(.title3)
                .bold()
            
            ForEach(0..<3, id: \.self) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 2, height: 30)
                        .foregroundStyle(.red)

                    VStack {
                        Image(systemName: "car")
                        Text("정비")
                            .font(.caption)
                    }
                    Spacer()
                    Text("9월 10일")
                        .font(.caption)
                }
                .padding(10)
                .padding(.vertical, 5)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
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
