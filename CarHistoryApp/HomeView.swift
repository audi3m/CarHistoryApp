//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct HomeView: View {
    @State private var car = Car.ferrari
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Image("ferrari")
                        .resizable()
                        .scaledToFill()
                        .padding()
                }
                
                nearby()
                recent()
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
            }
        }
    }
}

extension HomeView {
    private func nearby() -> some View {
        VStack(alignment: .leading) {
            Text("주변")
                .font(.title3)
                .bold()
            
            HStack {
                ForEach(0..<4, id: \.self) { idx in
                    NavigationLink {
                        
                    } label: {
                        Text("주유소")
                            .font(.caption)
                            .foregroundStyle(.blackWhite)
                            .padding(10)
                            .background(.red.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity)
                    
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
                    VStack {
                        Image(systemName: "car")
                        Text("정비")
                            .font(.caption)
                    }
                    Spacer()
                    Text("9월 10일")
                }
                .padding(10)
                .background(.blue.opacity(0.2))
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
