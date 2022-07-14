//
//  CoeusResultService.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/14/22.
//

import Foundation

class CoeusReportService: ObservableObject {
	static let shared = CoeusReportService()
	
	let defaultReportFileDir: URL
	
	private init() {
		let appStorage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		
		self.defaultReportFileDir = appStorage.appendingPathComponent("Reports/Generated", conformingTo: .directory)
		
		if !defaultReportDirExist() {
			createReportFileDir()
		}
	}
	
	func defaultReportDirExist() -> Bool {
		return FileManager.default.fileExists(atPath: defaultReportFileDir.path())
	}
	
	func createReportFileDir() {
		do {
			// Find library dir
			let fileManager = FileManager.default
			let appStorage = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
			
			print(appStorage.absoluteString)
			// Create sub-dirs
			try fileManager.createDirectory (at: defaultReportFileDir, withIntermediateDirectories: true, attributes: nil)
		} catch {
			print("An error occured during dirctory initialization")
		}
	}

	func prepareOutput(_ config: inout CoeusConfig) {
		// if the output file is not specified, simply create a default one and store it.
		if !FileManager.default.fileExists(atPath: config.outputFilePath) {
			let newReportPath = defaultReportFileDir.appending(path: "/\(config.id.uuidString)_report.json")
			print("New Report path is: \(newReportPath.path())")
			
			FileManager.default.createFile(atPath: newReportPath.path(), contents: Data())
			
			config.outputFilePath = newReportPath.path()
		}
	}
}
