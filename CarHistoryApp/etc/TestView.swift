//
//  TestView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/25/24.
//

import SwiftUI
import MapKit

enum SearchItem: CaseIterable {
  case parking
  case fuel
  case repair
  case wash
  
  var image: String {
    switch self {
    case .parking:
      "parkingsign"
    case .fuel:
      "fuelpump.fill"
    case .repair:
      "wrench.and.screwdriver"
    case .wash:
      "bubbles.and.sparkles"
    }
  }
}

struct TestView: View {
  
  @State private var selectedItem = SearchItem.parking
  @Namespace private var pickerSpace
  
  var body: some View {
    HStack {
      ForEach(SearchItem.allCases, id: \.self) { item in
        Image(systemName: item.image)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 8)
          .background {
            if selectedItem == item {
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 2, y: 2)
                .matchedGeometryEffect(id: "TAB", in: pickerSpace)
            }
          }
          .onTapGesture {
            withAnimation {
              selectedItem = item
            }
          }
      }
    }
    .padding(.vertical, 4)
    .padding(.horizontal, 8)
    .background(
      RoundedRectangle(cornerRadius: 10, style: .continuous)
        .fill(.gray.opacity(0.2))
    )
    .frame(width: 250)
  }
}

#Preview {
  TestView()
}
