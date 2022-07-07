//
//  ConfigDetailView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/2/22.
//

import SwiftUI
import CodeEditor

enum CallDataType {
	case message
//	case method
	case protobuf
}

struct ProtobufEditView: View {
	@State private var protobufText: String = "Please enter the definition of your .protobuf file"
	@State private var language = CodeEditor.Language.init(rawValue: "protobuf")
	
	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					print("Save pressed")
				} label: {
					Text("Save")
				}
				.standardButton()
			}

			
			CodeEditor(source: $protobufText, language: language, theme: .init(rawValue: "xcode"))
		}
	}
}

struct MessageEditView: View {
	@State private var fullText: String = "Please compose the message in JSON"
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
		case .protobuf:
			ProtobufEditView()
		}
	}
}

struct ConfigEditView: View {
	@State private var selectedDataType: CallDataType = .protobuf
	@State var config: CoeusConfig
	
	var body: some View {
		Form {
			Section() {
				Picker("Edit Data", selection: $selectedDataType) {
					Text("Protobuf").tag(CallDataType.protobuf)
					Text("Messages").tag(CallDataType.message)
				}
				.pickerStyle(.segmented)
			}

			SelectedEditorView(selected: $selectedDataType, config: config)
		}
		.padding()
	}
}

struct ConfigDetailView: View {
	@Binding var config: CoeusConfig?
	
	var InvokeButton: some View {
		Button {
			print("Invoking")
		} label: {
			Image(systemName: "paperplane")
		}
	}
	
	var ConfigEditSection: some View {
		VStack {
			HStack {
				Text(config!.targetHost).bold().font(.title)
				Spacer()
				InvokeButton
			}.padding()
			
			ConfigEditView(config: config!)
		}
	}
	
	var RemoteCallResponseSection: some View {
		Text("Invoke above methods to display a response")
	}
	
	var body: some View {
		if config != nil {
			VSplitView {
				ConfigEditSection
					.frame(minHeight: 250, idealHeight: 350)
				
				RemoteCallResponseSection
					.frame(maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
			}
		} else {
			Text("Please Select a config")
		}
	}
}
