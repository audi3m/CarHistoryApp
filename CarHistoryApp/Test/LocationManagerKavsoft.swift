//
//  LocationManagerKavsoft.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/25/24.
//

import Foundation
import MapKit
import Combine

final class LocationManagerKavsoft: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    @Published var manager = CLLocationManager()
    var cancellable: AnyCancellable?
    
    @Published var searchText = ""
    @Published var fetchedPlaces: [CLPlacemark]?
    @Published var userLocation: CLLocation?
    @Published var pickedLocation: CLLocation?
    @Published var pickedPlaceMark: CLPlacemark?
    
    
    override init() {
        super.init()
        mapView.delegate = self
        manager.delegate = self
        
        manager.requestWhenInUseAuthorization()
        
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { value in
                if !value.isEmpty {
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            }
    }
    
    private func fetchPlaces(value: String) {
        Task {
            do {
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                
                await MainActor.run {
                    self.fetchedPlaces = response.mapItems.compactMap { item -> CLPlacemark? in
                        return item.placemark
                    }
                }
                
            } catch {
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        self.userLocation = currentLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        // Error
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            handleLocationError()
        default: ()
        }
    }
    
    private func handleLocationError() { 
        
    }
    
    func addDraggablePin(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Food will be delivered here"
        
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DELIVERYPIN")
        marker.isDraggable = true
        marker.canShowCallout = false
        return marker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else { return }
        pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
        updatePlacemark(location: .init(latitude: newLocation.latitude, longitude: newLocation.longitude))
    }
    
    func updatePlacemark(location: CLLocation) {
        Task {
            do {
                guard let place = try await reverseLocationCoordinates(location: location) else { return }
                await MainActor.run {
                    self.pickedPlaceMark = place
                }
            } catch {
                
            }
        }
    }
    
    private func reverseLocationCoordinates(location: CLLocation) async throws -> CLPlacemark? {
        let place = try await CLGeocoder().reverseGeocodeLocation(location).first
        return place
    }
    
}
