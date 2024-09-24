//
//  TestView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/24/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Image(systemName: "car.side")
            .resizable()
            .fontWeight(.thin)
            .scaledToFit()
            .frame(height: 120)
    }
}

#Preview {
    TestView()
}
