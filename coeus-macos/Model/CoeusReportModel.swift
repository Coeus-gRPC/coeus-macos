//
//  CoeusReportDataModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/14/22.
//

import Foundation

struct CoeusReport: Codable {
	// UUID that tracks the report
	var id: UUID
	// UUID that tracks the configuration used to generate the report
	var configID: UUID
	
	var totalCallNum: Int
	var successCallCount: Int
	var concurrencyLevel: Int
	var totalTimeConsumption: Float
	var averageTimeConsumption: Float
	var fastestTimeConsumption: Float
	var slowestTimeConsumption: Float
	var timeConsumptions: [Float]
	var distribution: [String: Float]
	var requestPerSecond: Float
	var messages: [String]
	
	init(id: UUID = UUID(), configID: UUID = UUID(), totalCallNum: Int = -1, successCallCount: Int = -1, concurrencyLevel: Int = -1, totalTimeConsumption: Float = 0.0, averageTimeConsumption: Float = 0.0, fastestTimeConsumption: Float = 0.0, slowestTimeConsumption: Float = 0.0, timeConsumptions: [Float] = [Float](), distribution: [String : Float] = [String : Float](), requestPerSecond: Float = 0.0, messages: [String] = [String]()) {
		self.id = id
		self.configID = configID
		self.totalCallNum = totalCallNum
		self.successCallCount = successCallCount
		self.concurrencyLevel = concurrencyLevel
		self.totalTimeConsumption = totalTimeConsumption
		self.averageTimeConsumption = averageTimeConsumption
		self.fastestTimeConsumption = fastestTimeConsumption
		self.slowestTimeConsumption = slowestTimeConsumption
		self.timeConsumptions = timeConsumptions
		self.distribution = distribution
		self.requestPerSecond = requestPerSecond
		self.messages = messages
	}
	
	static func NewDummyReport() -> CoeusReport {
		var newDummy = CoeusReport()
		newDummy.id = UUID()
		newDummy.id = UUID()
		
		return newDummy
	}
}
