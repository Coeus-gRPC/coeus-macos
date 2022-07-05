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


struct SendView: View {
	@State private var selectedConfig: CoeusConfig?

	var items = ["a", "b", "c"]
	
	var donutViewer: some View {
		VStack {
//			Button {
//				print("Lalala")
//			} label: {
//				HStack{
//					Image(systemName: "plus.square")
//					Text("Add a Configuration")
//				}
//			}.buttonStyle(GrowingButton())

			List(CoeusConfigService.shared.configFiles, selection: $selectedConfig) { config in
				NavigationLink(destination: ConfigDetailView(config)) {
						ConfigDisplayRowView(title: config.id!.uuidString)
				}
			}
		}
//		.frame(minWidth: 50, minHeight: 400)
		.listRowInsets(.init())
		.padding(.horizontal, 40)
		.padding(.vertical)
		.background()
	}
	
	var body: some View {
		NavigationSplitView {
			donutViewer
				.frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: .infinity)
		} detail: {
			Image(systemName: "doc.circle")
		}
	}
}

