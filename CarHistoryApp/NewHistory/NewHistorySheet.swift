//
//  NewHistorySheet.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/15/24.
//

import SwiftUI

struct NewHistorySheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var type = HistoryType.refuel
    @State private var date = Date.now
    @State private var contentText = ""
    @State private var cost = ""
    @State private var price = ""
    @State private var volume = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                imagePicker()
                 
                // 내용
                content()
                
                DatePicker("날짜", selection: $date, displayedComponents: .date)
                    .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text("위치")
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                .padding(.horizontal)
                
            }
            .navigationTitle("New History")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

// Image picker
extension NewHistorySheet {
    private func imagePicker() -> some View {
        Image("car")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding()
    }
}


// 내용
extension NewHistorySheet {
    
    private func content() -> some View {
        VStack {
            Picker("타입", selection: $type) {
                ForEach(HistoryType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            switch type {
            case .refuel:
                refuelContent()
            case .maintenance:
                maintenanceContent()
            case .carWash:
                carWashContent()
            case .etc:
                othersContent()
            }
            
        }
        .padding(.horizontal)
    }
    
    private func refuelContent() -> some View {
        VStack(spacing: 12) {
            CustomTextField(image: "dollarsign", placeHolder: "비용", text: $cost)
            CustomTextField(image: "tag", placeHolder: "가격", text: $price)
            CustomTextField(image: "drop.halffull", placeHolder: "양", text: $volume)
        }
        .keyboardType(.numberPad)
        .padding(.vertical)
    }
    
    private func maintenanceContent() -> some View {
        VStack(spacing: 12) {
            CustomTextField(image: "dollarsign", placeHolder: "비용", text: $cost)
            CustomTextField(image: "text.quote", placeHolder: "내용", text: $contentText)
        }
        .padding(.vertical)
    }
    
    private func carWashContent() -> some View {
        VStack(spacing: 12) {
            CustomTextField(image: "dollarsign", placeHolder: "비용", text: $cost)
            CustomTextField(image: "text.quote", placeHolder: "내용", text: $contentText)
                .lineLimit(5...)
        }
        .padding(.vertical)
    }
    
    private func othersContent() -> some View {
        VStack(spacing: 12) {
            CustomTextField(image: "dollarsign", placeHolder: "비용", text: $cost)
            CustomTextField(image: "text.quote", placeHolder: "내용", text: $contentText)
                .lineLimit(5...)
        }
        .padding(.vertical)
    }
}

#Preview {
    NewHistorySheet()
}
