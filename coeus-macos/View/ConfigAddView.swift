//
//  ConfigAddView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/30/22.
//

import SwiftUI

struct ConfigAddView: View {
	@ObservedObject var configVM = ConfigAddViewModel()
	@State var filename = ""
	@State var showFileChooser = false

	var body: some View {
		VStack {
			if filename == "" {
				Text("No configuration uploaded, please upload a valid Coeus configuration file ending below")
			} else {
				Text(filename)
			}
			
			Button("select File") {
				let panel = NSOpenPanel()
				panel.allowsMultipleSelection = false
				panel.canChooseDirectories = false
				if panel.runModal() == .OK {
					self.filename = panel.url?.lastPathComponent ?? "<none>"
				}
			}
			.frame(maxWidth: 500, maxHeight: 500)
		}.padding()
	}
}
