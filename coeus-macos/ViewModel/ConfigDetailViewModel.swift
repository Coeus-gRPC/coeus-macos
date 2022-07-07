//
//  ConfigDetailViewModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/10/22.
//

import Foundation

class ConfigDetailViewModel: ObservableObject {
	
	func readMessageStr() -> String {
		return "Please enter the definition of the message here"
	}
	
	func readProtobufStr() -> String {
		return "Please enter the definition of your .protobuf file here"
	}
}

