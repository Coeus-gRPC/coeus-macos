//
//  ViewModifiers.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/4/22.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
      configuration.label
          .padding()
          .tint(.accentColor)
//          .background(.blue)
//          .foregroundColor(.white)
          .clipShape(Capsule())
          .scaleEffect(configuration.isPressed ? 1.2 : 1)
          .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
  }
}
