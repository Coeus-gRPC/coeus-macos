//
//  CoeusReportDataModel.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/14/22.
//

import Foundation

struct ReportDataModel: Codable {
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
}
