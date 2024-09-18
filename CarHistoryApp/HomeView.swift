//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var car = Car.ferrari
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                summary()
                grid()
                nearby()
                recent()
                    .padding(.bottom, 100)
            }
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottomTrailing) {
                addNewHistoryButtom()
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
    }
}

// Nav
extension HomeView {
    private func carSelector() -> some View {
        Menu {
            ForEach(Car.allCases, id: \.self) { option in
                Button {
                    car = option
                } label: {
                    Text(option.rawValue)
                }
            }
        } label: {
            HStack {
                Text(car.rawValue)
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
    private func addNewHistoryButtom() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
                .foregroundStyle(.whiteBlack, .blue)
        }
        .padding()
    }
    
    
}

// Main Views
extension HomeView {
    
    private func grid() -> some View {
        VStack(alignment: .leading) {
            
            Text("섹션 제목")
                .font(.title3)
                .bold()
            
            LazyVGrid(columns: columns) {
                ForEach(ShortcutLink.allCases, id: \.self) { link in
                    VStack(spacing: 4) {
                        Image(systemName: link.image)
                        Text(link.rawValue)
                            .font(.caption)
                    }
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
        }
        .padding()
        
    }
    
    private func summary() -> some View {
        VStack {
            Image("ferrari")
                .resizable()
                .scaledToFill()
                .frame(width: 300)
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
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
    }
}

extension HomeView {
    enum Car: String, CaseIterable {
        case ferrari = "Ferrari"
        case asd = "asd"
    }
}

#Preview {
    HomeView()
}
