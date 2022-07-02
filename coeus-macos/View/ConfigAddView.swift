//
//  ConfigAddView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/30/22.
//

import SwiftUI

struct ConfigAddView: View {
	@ObservedObject var configVM = ConfigAddViewModel()
	@State var filePath = URL(string: "")
	@State var configFileNotValid = false
	@State var showFileChooser = false

	var body: some View {
		VStack {
			Button("select File") {
				let panel = NSOpenPanel()
				panel.allowsMultipleSelection = false
				panel.canChooseDirectories = false
				if panel.runModal() == .OK {
					self.filePath = panel.url
				}
					
				configFileNotValid = !CoeusConfigService.shared.addConfigFile(filePath)
			}
		}
		.padding()
		.alert(
			"Fail to Add Configuration Files", isPresented: $configFileNotValid
		) {
			Button("Retry") {
				// handle retry action.
			}
		} message: {
			Text("Fail to parse Coeus Config file: \(filePath?.path() ?? "") ")
		}
	}
}
