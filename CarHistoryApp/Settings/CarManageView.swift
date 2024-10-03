//
//  CarManageView.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/3/24.
//

import SwiftUI
import RealmSwift

struct CarManageView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedResults(Car.self) var cars
    
    @State private var checkDeleteAll = false
    
    var body: some View {
        List {
            ForEach(cars) { car in
                Text(car.plateNumber)
            }
            .onDelete(perform: deleteCar(atOffsets:))
        }
        .navigationTitle("차량관리")
        .alert("등록된 차량이 없습니다", isPresented: $checkDeleteAll) {
            Button("삭제") {
                
            }
            Button("닫기", role: .cancel) { }
        } message: {
            Text("차량을 등록한 후에 기록을 추가할 수 있습니다")
        }
    }
    
    private func deleteCar(atOffsets: IndexSet) {
        
    }
}

#Preview {
    CarManageView()
}
