//
//  NearbyMapView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/20/24.
//

import SwiftUI

struct NearbyMapView: View {
    let place: String
    var body: some View {
        Text(place)
    }
}

#Preview {
    NearbyMapView(place: "주차장")
}
