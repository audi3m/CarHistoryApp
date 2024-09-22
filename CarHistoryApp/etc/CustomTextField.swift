//
//  CustomTextField.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/19/24.
//

import SwiftUI

struct CustomTextField: View {
    let image: String
    let placeHolder: String
    var axis = Axis.horizontal
    
    @FocusState private var focusField
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .frame(width: 21)
            
            TextField(placeHolder, text: $text) 
                .focused($focusField)
                .onSubmit {
                    focusField = false
                }
        }
    }
}

struct CustomTextField2: View {
    let image: String
    let placeHolder: String
    var axis = Axis.horizontal
    
    @FocusState private var focusField
    
    @Binding var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blackWhite.opacity(0.7))
                .frame(width: 20, height: 20)
                .padding(10)
                .background(.gray.opacity(0.2))
                .clipShape(Circle())
            
            TextField(placeHolder, text: $text, axis: axis)
                .lineLimit(1)
                .focused($focusField)
                .onSubmit {
                    focusField = false
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(minHeight: 40)
                .background(RoundedRectangle(cornerRadius: 4).stroke(.blackWhite.opacity(0.2), lineWidth: 1))
                .padding(.leading)
        }
    }
}



#Preview {
    CustomTextField(image: "car", placeHolder: "테스트", text: .constant("ㅁㄴㅇ"))
}
