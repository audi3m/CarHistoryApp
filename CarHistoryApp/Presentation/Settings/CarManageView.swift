//
//  CarManageView.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/3/24.
//

import SwiftUI

struct CarManageView: View {
  @EnvironmentObject var dataManager: LocalDataManager
  
  @State private var showDeleteConfirmation = false
  @State private var deleteOffsets: IndexSet?
  
  var body: some View {
    List {
      ForEach(dataManager.cars) { car in
        Text(car.plateNumber)
      }
      .onDelete { offsets in
        deleteOffsets = offsets
        showDeleteConfirmation = true
      }
    }
    .navigationTitle("차량관리")
    .alert(isPresented: $showDeleteConfirmation) {
      Alert(
        title: Text("삭제 확인"),
        message: Text("이 차량 및 관련 로그를 삭제하시겠습니까?"),
        primaryButton: .destructive(Text("삭제")) {
          if let offsets = deleteOffsets {
            deleteCarLogs(at: offsets)
            deleteOffsets = nil
          }
        },
        secondaryButton: .cancel(Text("취소"))
      )
    }
  }
  
  private func deleteCarLogs(at offsets: IndexSet) {
    for index in offsets {
      let carToDelete = dataManager.cars[index]
      CarImageManager.removeImageFromDocument(filename: "\(carToDelete.id)")
      dataManager.deleteCar(car: carToDelete) 
    }
  }
}

#Preview {
  CarManageView()
}
