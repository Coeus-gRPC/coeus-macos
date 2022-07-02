//
//  SidebarView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

enum SidebarItem: Hashable {
	case endpointsSend
	case endpointsAdd
	case reportsAll
	case reportsNew
}

struct SampleView: View {
	var body: some View {
		Text("Sample View")
	}
}

struct SidebarView: View {
	@State private var selectedItem: SidebarItem = .endpointsSend
	
	var body: some View {
		List(selection: $selectedItem) {
			endpointsSection
			
			reportsSection
		}
		.listStyle(.sidebar)
	}
	
	private var endpointsSection: some View {
		Section(header: Text("Endpoints")) {
			NavigationLink(destination: SendView()) {
				Label("Send", systemImage: "paperplane")
			}
			.tag(SidebarItem.endpointsSend)
			
			NavigationLink(destination: ConfigAddView()) {
				Label("Add", systemImage: "plus.app")
			}
			.tag(SidebarItem.endpointsAdd)
		}
	}
	
	private var reportsSection: some View {
		Section(header: Text("Report")) {
			NavigationLink(destination: SampleView()) {
				Label("All", systemImage: "archivebox")
			}
			.tag("All")
			
			NavigationLink(destination: SampleView()) {
				Label("New", systemImage: "arrow.up.doc")
			}
			.tag("New")
		}
		
	}
}
