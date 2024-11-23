//
//  TestCarListView.swift
//  CarHistoryApp
//
//  Created by J Oh on 11/19/24.
//

import SwiftUI

struct TestCarListView: View {
    @EnvironmentObject var dataManager: LocalDataManager
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataManager.cars) { car in
                    Text("\(car.plateNumber)")
                        .swipeActions {
                            Button("삭제") {
                                dataManager.deleteCar(car: car)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    TestCarListView()
}
