//
//  Collapsible.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/19/22.
//

import SwiftUI

struct Collapsible<Content: View>: View {
	@State var label: () -> Text
	@State var content: () -> Content
	
	@State private var collapsed: Bool = false
	
	var body: some View {
		VStack {
			Button {
				collapsed.toggle()
			} label: {
				HStack {
					Image(systemName: "mail.stack")
					label()
						.fixedSize()
					Spacer()
					Image(systemName: collapsed ? "chevron.down" : "chevron.up")
				}
				.frame(height: 15)
				.padding()
			}
			.buttonStyle(.plain)
			
			VStack {
				content()
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
			.clipped()
			.animation(.easeOut, value: collapsed)
			.transition(.slide)
			
			Spacer()
		}
		.background(Color.white)
	}
}
