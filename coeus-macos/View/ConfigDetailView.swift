//
//  ConfigDetailView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/2/22.
//

import SwiftUI

enum CallDataType {
	case message
	case method
	case protobuf
}

struct MessageEditView: View {
	@State private var fullText: String = "..."
	@State var config = CoeusConfig()
	
	init(config: CoeusConfig) {
		self.config = config
		print("Message Data FilePath: \(config.messageDataFile)")
		
		let messageData = FileManager.default.contents(atPath: config.messageDataFile) ?? Data()
		
		
		let messageStr = String(decoding: messageData, as: UTF8.self)
		
		print("Message String: \(messageStr)")
		
	}
	
	var body: some View {
		TextEditor(text: $fullText)
			.foregroundColor(Color.gray)
			.font(.custom("HelveticaNeue", size: 13))
			.lineSpacing(5)
	}
}

struct SelectedEditorView: View {
	@Binding var selected: CallDataType
	@State var config: CoeusConfig
	
	@ViewBuilder
	var body: some View {
		switch selected {
		case .message:
			MessageEditView(config: config)
		case .method:
			Text("Method edit")
		case .protobuf:
			Text("Protobuf edit")
		}
	}
}

struct ConfigEditView: View {
	@State private var selectedDataType: CallDataType = .message
	@State var config: CoeusConfig
	
	var body: some View {
		Form {
			Section() {
				Picker("Edit Data", selection: $selectedDataType) {
					Text("Messages").tag(CallDataType.message)
					Text("Method").tag(CallDataType.method)
					Text("Protobuf").tag(CallDataType.protobuf)
				}
				.pickerStyle(.segmented)
			}

			SelectedEditorView(selected: $selectedDataType, config: config)
		}
		.padding()
	}
}

struct ConfigDetailView: View {
	var config: CoeusConfig
	
	init(_ config: CoeusConfig) {
		self.config = config
	}
	
	var invokeButton: some View {
		Button {
			print("Invoking")
		} label: {
			Image(systemName: "paperplane")
		}
	}
	
	var body: some View {
		VStack {
			HStack {
				Text(config.targetHost).bold().font(.title)
				Spacer()
				
				invokeButton
				
			}.padding()
			
			ConfigEditView(config: config)
			Spacer()
		}
	}
}

struct ConfigDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigDetailView(CoeusConfig(totalCallNum: 5, concurrent: 2, targetHost: "api.coeustool.dev:443", insecure: false, timeout: 5000, protoFile: "", methodName: "greeterservice.Greeter.SayHello", messageDataFile: "", outputFilePath: ""))
    }
}
