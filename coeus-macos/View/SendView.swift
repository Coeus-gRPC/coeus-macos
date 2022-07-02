//
//  SendView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import SwiftUI

struct ConfigDisplayRowView: View {
	var title: String
	
	var body: some View {
		HStack {
			Image(systemName: "mail")
			Text(title)
		}
	}
}

struct ConfigDetailView: View {
	var config: CoeusConfig
	
	init(_ config: CoeusConfig) {
		self.config = config
	}
	
	var body: some View {
		Text(config.targetHost)
	}
}

struct SendView: View {
	@State private var selectedConfig: CoeusConfig?
	
	var body: some View {
		
		NavigationView {
			List(CoeusConfigService.shared.configFiles, selection: $selectedConfig) { config in
				NavigationLink(destination: ConfigDetailView(config)) {
					ConfigDisplayRowView(title: config.id!.uuidString)
				}
			}
			
			if ((selectedConfig?.id?.uuidString) == nil) {
				Text("Please Select an config")
			}
		}
	}
}

