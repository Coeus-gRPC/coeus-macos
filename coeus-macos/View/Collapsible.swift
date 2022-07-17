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
					label()
					Spacer()
					Image(systemName: collapsed ? "chevron.down" : "chevron.up")
				}
				.padding(.bottom, 1)
				.background(Color.white.opacity(0.01))
			}
			
			VStack {
				content()
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: collapsed ? 0 : .none)
			.clipped()
			.animation(.easeOut, value: collapsed)
			.transition(.slide)
		}
	}
}
