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
			Image(systemName: "mail")
			Text(title)
		}
		.background(self.isSelected ? Color.accentColor : Color.white)
	}
}


struct SendView: View {
	@State private var selected: CoeusConfig?

	var body: some View {
		HSplitView {
			List {
				ForEach(CoeusConfigService.shared.configFiles, id: \.self) { config in
					Button {
						if self.selected == config {
							self.selected = nil
						} else {
							self.selected = config
						}
					} label: {
						ConfigDisplayRowView(isSelected: self.selected == config, title: config.id!.uuidString)
					}
				}
			}
			.frame(minWidth: 100)
			
			ConfigDetailView(config: $selected)
				.frame(minWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

