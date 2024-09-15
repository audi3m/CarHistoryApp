//
//  HomeView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            Image("car")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .clipped()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
