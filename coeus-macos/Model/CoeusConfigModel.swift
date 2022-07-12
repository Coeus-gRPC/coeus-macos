//
//  CoeusConfig.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import Foundation

struct CoeusConfig: Codable, Identifiable, Hashable {
	var id: UUID?
	
	var totalCallNum: Int
	var concurrent: Int
	var targetHost: String
	var insecure: Bool
	var timeout: Int
	var protoFile: String
	var methodName: String
	var messageDataFile: String
	var outputFilePath: String

	init(id: UUID = UUID(), totalCallNum: Int = -1, concurrent: Int = -1, targetHost: String = "New Configuration", insecure: Bool = false, timeout: Int = 0, protoFile: String = "", methodName: String = "", messageDataFile: String = "", outputFilePath: String = "") {
		self.id = id
		self.totalCallNum = totalCallNum
		self.concurrent = concurrent
		self.targetHost = targetHost
		self.insecure = insecure
		self.timeout = timeout
		self.protoFile = protoFile
		self.methodName = methodName
		self.messageDataFile = messageDataFile
		self.outputFilePath = outputFilePath
	}
	
	static func NewDummyConfig() -> CoeusConfig {
		var newDummy = CoeusConfig()
		newDummy.id = nil
		return newDummy
	}
}
