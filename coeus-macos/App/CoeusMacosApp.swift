//
//  coeus_macosApp.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

@main
struct CoeusMacosApp: App {
	@StateObject private var model = CoeusMacModel()
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				SidebarView()
			}
		}
	}
}
