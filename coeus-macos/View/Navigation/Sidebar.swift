//
//  Sidebar.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/4/22.
//

import SwiftUI

struct Sidebar: View {
	@Binding var selection: SidebarItem
	
	var body: some View {
		List(selection: $selection) {
			Section(header: Text("Endpoints")) {
				NavigationLink(value: SidebarItem.endpointsSend) {
					Label("Send", systemImage: "paperplane")
				}
				
				NavigationLink(value: SidebarItem.endpointsAdd ) {
					Label("Add", systemImage: "plus.app")
				}
			}
				
			Section(header: Text("Report")) {
				NavigationLink(value: SidebarItem.reportsAll) {
					Label("All", systemImage: "archivebox")
				}
			}
		}
		.navigationTitle("Food Truck")
		.navigationSplitViewColumnWidth(min: 200, ideal: 200)
	}
}
