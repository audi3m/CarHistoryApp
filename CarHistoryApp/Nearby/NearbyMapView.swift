//
//  NearbyMapView.swift
//  SideMenu
//
//  Created by J Oh on 9/28/24.
//

import SwiftUI
import MapKit

struct NearbyMapView: View {
    @ObservedObject var locationManager = LocationManager.shared
    @Environment(\.dismiss) private var dismiss
    
    let nearby: Nearby
    
    @State private var position: MapCameraPosition = .automatic
    @State private var region: MKCoordinateRegion = .init()
    @State private var isFirstAppear = true
    @State private var regionChanged = false
    @Namespace private var mapScope
    
    @State private var selectedPlace: Place?
    
    @State private var place: Place?
    @State private var address: String?
    
    @State private var mapSelection: MKMapItem?
    
    var body: some View {
        MapReader { reader in
            Map(position: $position, selection: $mapSelection) {
                
                UserAnnotation()
                
                ForEach(locationManager.searchedPlaces) { place in
                    Annotation(place.name, coordinate: place.coordinate) {
                        CustomMarker(nearby: nearby)
                            .scaleEffect(self.place == place ? 1.2 : 1)
                            .animation(
                                self.place == place ?
                                Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true) :
                                .default,
                                value: self.place == place
                            )
                            .onTapGesture {
                                mapSelection = MKMapItem(placemark: place.placemark)
                                self.place = place
                            }
                    }
                }
            }
            .mapControls {
                
            }
            .mapScope(mapScope)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isFirstAppear = false
                }
            }
            .onMapCameraChange { context in
                if !isFirstAppear {
                    region = context.region
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        regionChanged = true
                    }
                }
            }
            .onAppear {
                if let place = locationManager.userPlace {
                    position = .region(MKCoordinateRegion(center: place.coordinate, span: .span))
                    region = .init(center: place.coordinate, span: .span)
                }
                
                locationManager.search(for: nearby.query, in: region)
                
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
                } else {
                    Text("Address will appear here")
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            
            Divider()
                .padding(.vertical, 10)
            
            Button {
                selectedPlace = place
                dismiss()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.title3)
                    .foregroundStyle(.blackWhite)
                    .padding()
            }
        }
        .onChange(of: place) {
            address = place?.name ?? nearby.query
        }
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.whiteBlack)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
        .padding(.bottom, 10)
    }
}
 
