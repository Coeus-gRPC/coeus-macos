//
//  coeus_macosApp.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

@main
struct CoeusMacosApp: App {
	@StateObject private var model = CoeusConfigService.shared
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		
		MenuBarExtra {
			HStack {
				Text("Coeus Running...")
			}
		} label: {
			Label("Coeus", systemImage: "paperplane.fill")
		}
	}
}
