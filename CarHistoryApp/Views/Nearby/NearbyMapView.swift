//
//  NearbyMapView.swift
//  SideMenu
//
//  Created by J Oh on 9/28/24.
//

import SwiftUI
import MapKit

struct NearbyMapView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var locationManager = LocationManager()
    
    let nearby: Nearby
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var region: MKCoordinateRegion = .init()
    @State private var isFirstAppear = true
    @State private var regionChanged = false
    @Namespace private var mapScope
    
    @State private var selectedPlace: Place?
    @State private var address: String?
    
    @State private var mapSelection: MKMapItem?
    
    var body: some View {
        MapReader { reader in
            Map(position: $position, selection: $mapSelection) {
                
                UserAnnotation()
                
                ForEach(locationManager.searchedPlaces) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        CustomMarker(nearby: nearby)
                            .scaleEffect(self.selectedPlace == place ? 1.2 : 1)
                            .animation(
                                self.selectedPlace == place ?
                                Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true) :
                                .default,
                                value: self.selectedPlace == place
                            )
                            .onTapGesture {
                                mapSelection = MKMapItem(placemark: place.placemark)
                                self.selectedPlace = place
                            }
                    }
                }
            }
            .mapScope(mapScope)
            .mapControls {
                MapUserLocationButton(scope: mapScope)
            }
            .onMapCameraChange { context in
                if !isFirstAppear {
                    region = context.region
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        regionChanged = true
                    }
                }
            }
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let userPlace = locationManager.userPlace {
                        locationManager.search(for: nearby.query, in: .init(center: userPlace.coordinate, span: .span))
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFirstAppear = false
                }
            }
            .onDisappear {
                locationManager.deleteSearchResult()
            }
            .overlay(alignment: .bottom) {
                if regionChanged {
                    researchButton()
                        .padding(.bottom, 20)
                }
            }
            .overlay(alignment: .topLeading) {
                dismissButton()
                    .padding(.leading)
            }
        }
        .toolbar(.hidden)
        .safeAreaInset(edge: .bottom) {
            bottomSelector()
                .padding(.horizontal)
        }
    }
}

extension NearbyMapView {
    
    private func dismissButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.white, .gray)
                .shadow(radius: 3)
        }
        .clipShape(Circle())
        .shadow(radius: 3)
    }
    
    private func researchButton() -> some View {
        Button {
            locationManager.search(for: nearby.query, in: region)
            regionChanged = false
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                Text("현 지도에서 다시 검색")
            }
            .font(.subheadline)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                Capsule()
                    .fill(.whiteBlack)
                    .shadow(radius: 3)
            )
        }
    }
     
    private func bottomSelector() -> some View {
        HStack(spacing: 0) {
            
            Image(systemName: nearby.image)
                .font(.title2)
                .padding()
            
            Group {
                if let address {
                    Text(address)
                        .lineLimit(2)
                } else {
                    Text("이름")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            Divider()
                .padding(.vertical, 10)
            
            Button {
                if let selectedPlace {
                    LinkToApp.openInAppleMaps(place: selectedPlace)
                }
            } label: {
                Image(systemName: "arrow.right")
                    .font(.title3)
                    .foregroundStyle(.blackWhite)
                    .padding()
            }
        }
        .onChange(of: selectedPlace) {
            address = selectedPlace?.name ?? nearby.query
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(.whiteBlack)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
        .padding(.bottom, 10)
    }
}
