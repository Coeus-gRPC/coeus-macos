//
//  ConfigDetailViewModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/10/22.
//

import CodeEditor
import Foundation

class ConfigDetailViewModel: ObservableObject {
	func updateCallData(_ type: CallDataType, _ config: CoeusConfig, _ text: String) -> CoeusConfig {
		switch type {
		case .protobuf:
			return updateProtobufStr(config, text)
		case .message:
			return updateMessageStr(config, text)
		}
	}
	
	func readCallData(_ type: CallDataType, _ config: CoeusConfig) -> String {
		switch type {
		case .protobuf:
			return readProtobufStr(config)
		case .message:
			return readMessageStr(config)
		}
	}
	
	func setCodeEditorLanguage(_ type: CallDataType) -> CodeEditor.Language {
		switch type {
		case .protobuf:
			return CodeEditor.Language.init(rawValue: "protobuf")
		case .message:
			return CodeEditor.Language.json
		}
	}
	
	private func readMessageStr(_ config: CoeusConfig) -> String {
		let messageData = FileManager.default.contents(atPath: config.messageDataFile) ?? Data()
		let messageStr = String(decoding: messageData, as: UTF8.self)

		// There is no Message Data File or the data file cannot be accessed
		if messageStr == "" {
			return "Please enter the definition of the message here"
		} else {
			// There is Message Data File, and it is non empty
			return messageStr
		}
	}
	
	private func updateMessageStr( _ config: CoeusConfig, _ newMessage: String) -> CoeusConfig {
		if FileManager.default.fileExists(atPath: config.messageDataFile) {
			// Message data file exist,
			FileManager.default.createFile(atPath: config.messageDataFile, contents: newMessage.data(using: .utf8))
			
			return config
		} else {
			// File not exist, we need to create the file, update its content and record the file path
			let messageFileName = config.id.uuidString + "_message.json"
			let messageFilePath = CoeusConfigService.shared.messageFileDir.appending(path: "\(messageFileName)")
			
			FileManager.default.createFile(atPath: messageFilePath.path(), contents: newMessage.data(using: .utf8))
			
			var newConfig = config
			newConfig.messageDataFile = messageFilePath.path()
			let updateSuccess = CoeusConfigService.shared.updateConfigFile(newConfig)
			
			return updateSuccess ? newConfig : config
		}
	}
	
	private func readProtobufStr(_ config: CoeusConfig) -> String {
		print("config.protoFile: \(config.protoFile)")
		let protoData = FileManager.default.contents(atPath: config.protoFile) ?? Data()
		let protoStr = String(decoding: protoData, as: UTF8.self)
		
		if protoStr == "" {
			return "Please enter the definition of your .protobuf file here"
		} else {
			return protoStr
		}
	}
	
	private func updateProtobufStr(_ config: CoeusConfig, _ newProtobuf: String) -> CoeusConfig {
		if FileManager.default.fileExists(atPath: config.protoFile) {
			_ = FileManager.default.createFile(atPath: config.protoFile, contents: newProtobuf.data(using: .utf8))
			
			return config
		} else {
			let protoFileName = config.id.uuidString + ".proto"
			let protoFilePath = CoeusConfigService.shared.protobufFileDir.appending(path: "\(protoFileName)")
			
			FileManager.default.createFile(atPath: protoFilePath.path(), contents: newProtobuf.data(using: .utf8))
			
			var newConfig = config
			newConfig.protoFile = protoFilePath.path()
			let updateSuccess = CoeusConfigService.shared.updateConfigFile(newConfig)
			
			return updateSuccess ? newConfig : config
		}
	}
}

