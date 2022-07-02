//
//  CoeusMacViewModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import Foundation

var defaultConfigStr = """
{
	"totalCallNum": 20,
	"concurrent": 5,
	"targetHost": "api.coeustool.dev:443",
	"insecure": false,
	"timeout": -1,
	"protoFile": "./test/testdata/proto/greeter.proto",
	"methodName": "greeterservice.Greeter.SayHello",
	"messageDataFile": "./test/testdata/message/messageData.json",
	"outputFilePath": "./output/output.json"
}
"""

@MainActor
class CoeusConfigService: ObservableObject {
	static let shared = CoeusConfigService()
	
	var configFiles = [CoeusConfig]()
	let configFileDir: URL
	
	private init() {
		let appStorage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		self.configFileDir = appStorage.appendingPathComponent("ConfigFiles/", conformingTo: .directory)
		
		if !configFileDirExist() {
			createConfigFileDir()
		}
		
		configFiles = readConfigFiles()
	}
	
	func configFileDirExist() -> Bool {
		return FileManager.default.fileExists(atPath: configFileDir.path())
	}
	
	func createConfigFileDir() {
		do {
			print("Initing files")
			// Find library dir
			let fileManager = FileManager.default
			let appStorage = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
			
			print(appStorage.absoluteString)
			// Create sub-dir
			let dirURL = appStorage.appendingPathComponent("ConfigFiles/", conformingTo: .directory)
			try fileManager.createDirectory (at: dirURL, withIntermediateDirectories: true, attributes: nil)
			print("Dir Str", dirURL.absoluteString)

			// Create document
			let documentURL = dirURL.appending(path: "InitConfig.json")
			print(documentURL.absoluteString)
			
			// Write empty document
			let success = FileManager.default.createFile(atPath: documentURL.path(), contents: defaultConfigStr.data(using: .utf8))
			
			print("File creation was \(success)")
		} catch {
			print("An error occured during dirctory initialization")
		}
	}
	
	func readConfigFiles() -> [CoeusConfig] {
		let decoder = JSONDecoder()
		var inputConfigs = [CoeusConfig]()
		do {
			let configs = try FileManager.default.contentsOfDirectory(atPath: configFileDir.path())
			
			for configFilePath in configs {
				let configURL = configFileDir.appendingPathComponent(configFilePath)
				let configData = try Data(contentsOf: configURL)
				var configStruct = try decoder.decode(CoeusConfig.self, from: configData)

				configStruct.id = UUID()
				
				inputConfigs.append(configStruct)
			}
		} catch {
			print("An error occured during config file reading")
		}
		
		return inputConfigs
	}
	
	func addConfigFile(_ filePath: URL?) -> Bool {
		do {
			guard let configData = try? Data(contentsOf: filePath!) else { return false }
			
			var configStruct = try JSONDecoder().decode(CoeusConfig.self, from: configData)
			let id = UUID()
			configStruct.id = id
			configFiles.append(configStruct)
			
			try FileManager.default.copyItem(at: filePath!, to: configFileDir.appending(path: "\(id.uuidString).json"))
			
			return true
		} catch {
			print("An error occured during config file reading")
			
			return false
		}
	}
}
