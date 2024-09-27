//
//  LocationSelectView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/16/24.
//

import SwiftUI
import MapKit

struct LocationSelectView: View {
    @Binding var coordinates: CLLocationCoordinate2D?
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    LocationSelectView(coordinates: .constant(CLLocationCoordinate2D(latitude: 100, longitude: 30)))
}
