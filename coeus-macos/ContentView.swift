//
//  ContentView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedItem: SidebarItem = .endpoints
	
	var body: some View {
		NavigationSplitView {
			List(selection: $selectedItem) {
				
				Section("Endpoints") {
					HStack {
						Image(systemName: "tray.full")
							.imageScale(.medium)
							.frame(width: 20, height: 20)
						Text("All Endpoints")
					}
					
					HStack {
						Image(systemName: "plus.app")
							.imageScale(.medium)
							.frame(width: 20, height: 20)
						Text("Add Endpoint")
					}
					
				}
			}
		} detail: {
			Text("Wulala")
		}
		
//		VStack {
//			Image(systemName: "globe")
//				.imageScale(.large)
//				.foregroundColor(.accentColor)
//			Text("Hello, world!")
//
//			Button {
//				var message = ["--config"]
//				let exeURL = Bundle.main.url(forResource: "coeus-core", withExtension: "")
//
//				let configURL = Bundle.main.url(forResource: "testconfig", withExtension: "json")
//				message.append(configURL!.relativePath)
//
//				let task = Process()
//				task.executableURL = exeURL!
//				task.arguments = message
//
//				let outputPipe = Pipe()
//				let errorPipe = Pipe()
//				task.standardOutput = outputPipe
//				task.standardError = errorPipe
//
//				try! task.run()
//
//				let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
//				let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
//
//				let output = String(decoding: outputData, as: UTF8.self)
//				let error = String(decoding: errorData, as: UTF8.self)
//
//				print(error)
//				print(output)
//
//			} label: {
//				Text("Call binary")
//			}
//		}
	}
}

