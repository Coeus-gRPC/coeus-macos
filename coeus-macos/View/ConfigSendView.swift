//
//  SendView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import SwiftUI

struct ConfigDisplayRowView: View {
	@State var config: CoeusConfig
	var isSelected: Bool

	var body: some View {
		HStack {
			Rectangle()
				.fill(self.isSelected ? Color.accentColor : Color.clear)
				.frame(width: 3, height: 30)
				
			Image(systemName: "mail")
			Text(config.id!.uuidString)
				.fixedSize()
		}
		.background(self.isSelected ? Color.LightGrey : .clear)
	}
}


struct SendView: View {
	@ObservedObject var configService = CoeusConfigService.shared
	@State private var selected: CoeusConfig?

	init() {
		self.configService = CoeusConfigService.shared
		self.configService.syncConfigFiles()
		self.selected = nil
	}
	
	var ConfigSelection: some View {
		List {
			Section {
				ForEach(configService.configFiles, id: \.self) { config in
					Button {
						if self.selected == config {
							self.selected = nil
						} else {
							self.selected = config
						}
					} label: {
						ConfigDisplayRowView(config: config, isSelected: self.selected == config)
					}
					.contextMenu {
						Button {
							configService.deleteConfigFile(config)
							configService.syncConfigFiles()
							} label: {
								HStack {
									Image(systemName: "minus.square")
									Text("Menu title")
								}
							}
					}
					.buttonStyle(.plain)
				}
			}
		}
		.padding(.horizontal, -15)
		.frame(minWidth: 125)
	}
	
	var body: some View {
		HSplitView {
			ConfigSelection

			ConfigDetailView(config: $selected)
				.frame(minWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					selected = configService.createConfigFile()
					configService.syncConfigFiles()
				} label: {
					Image(systemName: "plus.square")
				}
			}
		}
	}
}

