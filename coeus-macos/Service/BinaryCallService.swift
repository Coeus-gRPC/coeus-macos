//
//  BinaryCallService.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/10/22.
//

import Foundation

class BinaryCallService: ObservableObject {
	static let shared = BinaryCallService()
	
	func InvokeRPC(_ config: CoeusConfig) -> String {
		var message = ["--config"]
		let exeURL = Bundle.main.url(forResource: "coeus-core", withExtension: "")
		
		let configURL = CoeusConfigService.shared.configFileDir.appending(path: "\(config.id!.uuidString).json")
		
		message.append(configURL.relativePath)
		
		let task = Process()
		task.executableURL = exeURL!
		task.arguments = message
		
		let outputPipe = Pipe()
		let errorPipe = Pipe()
		task.standardOutput = outputPipe
		task.standardError = errorPipe
		
		try! task.run()
		
		let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
		let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
		
		let output = String(decoding: outputData, as: UTF8.self)
		let error = String(decoding: errorData, as: UTF8.self)
		
		print(error)
		print(output)
		
		return error == "" ? output : error
	}
}
