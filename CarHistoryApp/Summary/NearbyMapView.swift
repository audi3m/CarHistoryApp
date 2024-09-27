//
//  NearbyMapView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/20/24.
//

import SwiftUI
import MapKit

struct NearbyMapView: View {
    @Environment(\.dismiss) private var dismiss
    let place: String
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.522075, longitude: 126.974957),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var parkingLocations: [MKMapItem] = []
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: parkingLocations) { place in
            MapMarker(coordinate: place.placemark.coordinate, tint: .blue)
        }
        .onAppear {
            searchNearby()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white, .blue)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
//    private func searchCategoryNearby() {
//        let request = MKLocalSearch.Request()
//        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.parking])
//        request.region = region
//        
//        let search = MKLocalSearch(request: request)
//        search.start { response, error in
//            guard let response = response else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            // Update parkings with search results
//            parkingLocations = response.mapItems
//        }
//    }
    
    private func searchNearby() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error searching for parking: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.parkingLocations = response.mapItems
            }
        }
    }
}

#Preview {
    NearbyMapView(place: "주차장")
}


