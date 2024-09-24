//
//  MileageView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/20/24.
//

/*
 ------------------------
 |                      |
 |  |                   |
 |  |         .. ..     |
 |  |..    ..           |
 |  |   ..              |
 |  |                   |
 |  ------------------  |
 |  평균연비              |
 |  월평균 주행거리         |
 |                      |
 |                      |
 | <        9월        > |
 |                      |
 |                      |
 |                      |
 |                      |
 |                      |
 ------------------------
 */


import SwiftUI
import Charts

struct MileageView: View {
    var body: some View {
        ScrollView {
            Chart {
                ForEach(DummyData.mileage) { data in
                    LineMark(
                        x: .value("Date", data.date),
                        y: .value("Mileage", data.mileage)
                    )
                }
            }
            .frame(height: 250)
            
        }
        
    }
}

#Preview {
    MileageView()
}
