//
//  ConfigAddViewModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/30/22.
//

import Foundation

class ConfigAddViewModel: ObservableObject {
	func decodeConfigFile(filePath: String) -> Bool {
		if !FileManager().fileExists(atPath: filePath) {
				return false
		}
		
	}
}
