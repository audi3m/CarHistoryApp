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
    @Binding var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.blackWhite.opacity(0.7))
                .frame(width: 16, height: 16)
                .padding(8)
                .background(.gray.opacity(0.2))
                .clipShape(Circle())
            
            TextField(placeHolder, text: $text, axis: .vertical)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(minHeight: 32)
                .background(RoundedRectangle(cornerRadius: 4).stroke(.blackWhite.opacity(0.2), lineWidth: 1))
                .padding(.leading)
        }
    }
}

#Preview {
    CustomTextField(image: "car", placeHolder: "테스트", text: .constant("ㅁㄴㅇ"))
}
