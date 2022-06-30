//
//  SidebarView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

enum SidebarItem: Hashable {
	case endpoints
	case reports
}

struct SampleView: View {
	var body: some View {
		Text("Sample View")
	}
}

struct SidebarView: View {
	@State private var selectedItem: SidebarItem = .endpoints
	
	var body: some View {
		List(selection: $selectedItem) {
			endpointsSection
			reportsSection
		}
		.listStyle(.sidebar)
	}
	
	private var endpointsSection: some View {
		Section(header: Text("Endpoints")) {
			NavigationLink(destination: SampleView()) {
				Label("Add", systemImage: "plus.app")
			}
			.tag("Add")
			
			NavigationLink(destination: SampleView()) {
				Label("Send", systemImage: "paperplane")
			}
			.tag("Send")
		}
	}
	
	private var reportsSection: some View {
		Section(header: Text("Report")) {
			NavigationLink(destination: SampleView()) {
				Label("All", systemImage: "archivebox")
			}
			.tag("All")
		}
	}
}
