//
//  SendView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import SwiftUI

struct ConfigDisplayRowView: View {
	var isSelected: Bool
	var title: String
	
	var body: some View {
		HStack {
			Rectangle()
				.fill(self.isSelected ? Color.accentColor : Color.clear)
				.frame(width: 3, height: 30)
				
			Image(systemName: "mail")
			Text(title)
				.fixedSize()
		}
		.background(self.isSelected ? Color.LightGrey : .clear)
	}
}


struct SendView: View {
	@State private var selected: CoeusConfig?

	var body: some View {
		HSplitView {
			List {
				Section {
					ForEach(CoeusConfigService.shared.configFiles, id: \.self) { config in
						Button {
							if self.selected == config {
								self.selected = nil
							} else {
								self.selected = config
							}
						} label: {
							ConfigDisplayRowView(isSelected: self.selected == config, title: config.id!.uuidString)
						}.buttonStyle(.plain)
					}
				}

			}
			.padding(.horizontal, -15)
			.frame(minWidth: 100)
			
			ConfigDetailView(config: $selected)
				.frame(minWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

