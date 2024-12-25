//
//  LogCell.swift
//  CarHistoryApp
//
//  Created by J Oh on 12/24/24.
//

import SwiftUI

struct LogCell: View {
    
    let log: LogDomain
    
    var body: some View {
        VStack {
            HStack {
                // 앞 표시
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 2.5, height: 35)
                    .foregroundStyle(log.typeColor)
                
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
            
//            if !log.notes.isEmpty {
//                Text(log.notes)
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//                    .padding(.leading, 40)
//            }
        }
        .padding(.horizontal, 10)
        .background(.cellBG)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .listRowBackground(Color.clear)
    }
}
