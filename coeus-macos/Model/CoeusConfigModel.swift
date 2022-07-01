//
//  CoeusConfig.swift
//  coeus-macos
//
//  Created by Yifan Huang on 6/29/22.
//

import Foundation

struct CoeusConfig: Codable, Identifiable {
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
}
