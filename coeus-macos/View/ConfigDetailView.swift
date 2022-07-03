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
	@State private var fullText: String = "This is some editable text..."
	
	var body: some View {
		TextEditor(text: $fullText)
			.foregroundColor(Color.gray)
			.font(.custom("HelveticaNeue", size: 13))
			.lineSpacing(5)
	}
}

struct SelectedEditorView: View {
	@Binding var selected: CallDataType
	
	@ViewBuilder
	var body: some View {
		switch selected {
		case .message:
			MessageEditView()
		case .method:
			Text("Method edit")
		case .protobuf:
			Text("Protobuf edit")
		}
	}
}

struct ConfigEditView: View {
	@State private var selectedDataType: CallDataType = .message
	
	var body: some View {
		Form {
			Section() {
				Picker("Select a color", selection: $selectedDataType) {
					Text("Message").tag(CallDataType.message)
					Text("B").tag(CallDataType.method)
					Text("C").tag(CallDataType.protobuf)
				}
				.pickerStyle(.segmented)
			}
			
			SelectedEditorView(selected: $selectedDataType)
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
				Text(config.targetHost)
					.bold()
					.font(.title)
				Spacer()
				
				invokeButton
				
			}.padding()
			
			ConfigEditView()
			Spacer()
		}
	}
}
struct ConfigDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigDetailView(CoeusConfig(totalCallNum: 5, concurrent: 2, targetHost: "api.coeustool.dev:443", insecure: false, timeout: 5000, protoFile: "", methodName: "greeterservice.Greeter.SayHello", messageDataFile: "", outputFilePath: ""))
    }
}
