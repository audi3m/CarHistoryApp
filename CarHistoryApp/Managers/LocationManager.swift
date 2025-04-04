//
//  LocationManager.swift
//  SideMenu
//
//  Created by J Oh on 9/28/24.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private let manager = CLLocationManager()
  
  @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
  @Published var userPlace: Place?
  
  @Published private(set) var searchedPlaces = [Place]()
  @Published private(set) var selectedItem: SearchedItem?
  
  override init() {
    super.init()
    manager.delegate = self
    checkDeviceLocationAuthorization()
  }
  
  func requestLocation() {
    manager.requestLocation()
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkDeviceLocationAuthorization()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let coordinate = locations.last?.coordinate else { return }
    userPlace = Place(latitude: coordinate.latitude, longitude: coordinate.longitude, name: "현재위치")
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Current Location Error: \(error.localizedDescription)")
  }
  
  func search(for text: String, in region: MKCoordinateRegion) {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = text
    request.region = region
    
    let search = MKLocalSearch(request: request)
    search.start { [weak self] response, error in
      guard let self else { return }
      guard let response else { return }
      
      DispatchQueue.main.async {
        self.searchedPlaces = response.mapItems.map { item in
          Place(latitude: item.placemark.coordinate.latitude,
                longitude: item.placemark.coordinate.longitude,
                name: item.name ?? "Unknown")
        }
      }
    }
  }
  
  func checkDeviceLocationAuthorization() {
    DispatchQueue.global().async {
      if CLLocationManager.locationServicesEnabled() {
        DispatchQueue.main.async {
          self.checkCurrentLocationAuthorization()
        }
      }
    }
  }
  
  func checkCurrentLocationAuthorization() {
    let status = manager.authorizationStatus
    switch status {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedWhenInUse, .authorizedAlways:
      manager.desiredAccuracy = kCLLocationAccuracyBest
      manager.startUpdatingLocation()
    default:
      print("Fail to get current location")
    }
  }
  
  func deleteSearchResult() {
    searchedPlaces.removeAll()
  }
}

extension CLLocationCoordinate2D {
  static let seoul = CLLocationCoordinate2D(latitude: 37.5642, longitude: 126.9927)
}

extension MKCoordinateSpan {
  static let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

struct SearchedItem: Identifiable {
  let id = UUID()
  let address: String
  let placemark: MKPlacemark
  
  var coordinate: CLLocationCoordinate2D
}

struct Place: Identifiable, Equatable, Codable {
  var id = UUID()
  let latitude: Double
  let longitude: Double
  let name: String
  
  var placemark: MKPlacemark {
    return MKPlacemark(coordinate: coordinate)
  }
  
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  var address: String {
    get async {
      let preferredLocale = Locale.preferredLanguages.first
      let locale = Locale(identifier: preferredLocale ?? "en")
      let location = CLLocation(latitude: latitude, longitude: longitude)
      
      do {
        let placemarks = try await CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale)
        guard let placemark = placemarks.first else {
          return "Unknown"
        }
        return MKPlacemark(placemark: placemark).title ?? "Unknown"
      } catch {
        print("Unable to reverse geocode the given location. Error: \(error.localizedDescription)")
        return "Unknown"
      }
    }
  }
}


