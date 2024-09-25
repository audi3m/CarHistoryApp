//
//  ContentView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SearchView()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ContentView()
}
