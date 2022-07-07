//
//  ViewModifiers.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/4/22.
//

import SwiftUI

struct StandardButton: ButtonStyle {
	var foregroundColor: Color
	var backgroundColor: Color
	
  func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(.horizontal, 6)
			.padding(.vertical, 3)
			.background(backgroundColor)
			.clipShape(RoundedRectangle(cornerRadius: 4.5))
			.foregroundColor(foregroundColor)
			.opacity(configuration.isPressed ? 0.8 : 1.0)
  }
}

extension View {
	func standardButton(
		foregroundColor: Color = .white,
		backgroundColor: Color = .accentColor
	) -> some View {
		self.buttonStyle(
			StandardButton(
				foregroundColor: foregroundColor,
				backgroundColor: backgroundColor
			)
		)
	}
}
