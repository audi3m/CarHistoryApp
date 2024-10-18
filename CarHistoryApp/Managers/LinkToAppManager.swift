//
//  LinkToAppManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/2/24.
//

import UIKit
import MapKit

enum LinkToAppManager {
    
    static func openInAppleMaps(place: Place) {
        let mapItem = MKMapItem(placemark: place.placemark)
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
