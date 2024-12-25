//
//  LogCellTest.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/24/24.
//

import SwiftUI

struct LogCellTest: View {
    
    let log: LogDomain
    
    @State private var expanded = false
    
    var body: some View {
        HStack {
            // 앞 표시
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 2.5)
                .foregroundStyle(log.typeColor)
                .padding(.vertical, 10)
            
            Image(systemName: log.logType.image)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(5)
            
            // 상호+가격
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
        .frame(height: 60)
        .padding(.horizontal, 10)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .listRowBackground(Color.clear)
    }
}


#Preview {
    LogCellTest(log: .randomLog())
}
