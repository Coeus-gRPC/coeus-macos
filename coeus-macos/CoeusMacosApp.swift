//
//  coeus_macosApp.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

@main
struct CoeusMacosApp: App {
	var body: some Scene {
		WindowGroup {
			NavigationView {
				SidebarView()
			}
		}
	}
}
