//
//  LinkToAppManager.swift
//  CarHistoryApp
//
//  Created by J Oh on 10/2/24.
//

import UIKit

enum LinkToAppManager {

    static func openLocationInGoogleMaps(place: Place) {
        let urlString = "comgooglemaps://?q=\(place.latitude),\(place.longitude)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            openLocationInBrowser(place: place)
        }
    }
    
    static func openLocationInBrowser(place: Place) {
        let urlString = "https://www.google.com/maps/search/?api=1&query=\(place.latitude),\(place.longitude)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
