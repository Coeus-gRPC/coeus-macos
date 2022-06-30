//
//  CoeusMacViewModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import Foundation

var jsonStr = """
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
public class CoeusMacModel: ObservableObject {
	public init() {
		do {
			print("Initing files")
			// Find library dir
			let fileManager = FileManager.default
			let appStorage = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
			
			print(appStorage.absoluteString)
			// Create sub-dir
//			let dirURL = appStorage.appendingPathExtension()
//			try fileManager.createDirectory (at: appStorage, withIntermediateDirectories: true, attributes: nil)
//			print(appStorage.absoluteString)

			// Create document
			let documentURL = appStorage.appending(path: "InitConfig.json")
			print(documentURL.absoluteString)
			
			// Write empty document
			let success = FileManager.default.createFile(atPath: documentURL.path(), contents: jsonStr.data(using: .utf8))
			
			print("File creation was \(success)")
			
		} catch {
			print("An error occured during dirctory initialization")
		}
	}
}
