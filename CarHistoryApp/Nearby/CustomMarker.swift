//
//  CustomMarker.swift
//  SideMenu
//
//  Created by J Oh on 9/28/24.
//

import SwiftUI

struct CustomMarker: View {
    let nearby: Nearby
    
    var body: some View {
        ZStack {
            Image(systemName: "drop.fill")
                .font(.system(size: 45))
                .foregroundStyle(nearby.color)
                .rotationEffect(.degrees(180))
                .shadow(color: .blackWhite, radius: 3)
            
            Image(systemName: nearby.image)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 18, height: 18)
                .offset(x: nearby == .parking ? 1.5 : 0, y: -4)
        }
    }
}

enum AnnotationSign: String, CaseIterable {
    case parking
    case gas
    case repair
    case wash
    
    var image: String {
        switch self {
        case .parking:
            "parkingsign"
        case .gas:
            "fuelpump.fill"
        case .repair:
            "wrench.and.screwdriver"
        case .wash:
            "bubbles.and.sparkles"
        }
    }
}
