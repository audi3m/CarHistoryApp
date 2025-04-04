//
//  OnboardingView.swift
//  CarHistoryApp
//
//  Created by J Oh on 9/22/24.
//

import SwiftUI

struct OnboardingView: View {
  @State private var text = ""
  @State private var type = SampleType.main
  var body: some View {
    NavigationStack {
      List {
        Section {
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: "car")
            TextField("asd", text: $text)
          }
          
          HStack(alignment: .top, spacing: 12) {
            Image(systemName: "car")
            TextField("qwe", text: $text, axis: .vertical)
              .lineLimit(3...)
          }
        }
        
        Section {
          Picker("타입", selection: $type) {
            Text(type.rawValue)
          }
        }
      }
      .navigationTitle("Test")
      .navigationBarTitleDisplayMode(.inline)
      //            .listStyle(.plain)
    }
  }
  
  enum SampleType: String, Hashable {
    case main
    case sub
  }
}
