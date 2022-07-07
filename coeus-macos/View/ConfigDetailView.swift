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
	case protobuf
}

struct CallDataEditView: View {
	@ObservedObject var viewModel: ConfigDetailViewModel
	@State private var text: String
	@State private var language: CodeEditor.Language

	init(_ editorType: CallDataType, _ viewModel: ConfigDetailViewModel) {
		self.viewModel = viewModel
		switch editorType {
		case .protobuf:
			self.language = CodeEditor.Language.init(rawValue: "protobuf")
			self.text = viewModel.readProtobufStr()
		case .message:
			language = CodeEditor.Language.json
			self.text = viewModel.readMessageStr()
		}
	}
	
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
			
			CodeEditor(source: text, language: language, theme: .init(rawValue: "xcode"))
		}
	}
}

struct ConfigEditView: View {
	@ObservedObject var viewModel: ConfigDetailViewModel
	@State private var selectedDataType: CallDataType = .protobuf
	@State var config: CoeusConfig
	
	@ViewBuilder
	var selectedEditorView: some View {
		switch selectedDataType {
		case .message:
			CallDataEditView(.message, viewModel)
		case .protobuf:
			CallDataEditView(.protobuf, viewModel)
		}
	}
	
	var body: some View {
		Form {
			Section() {
				Picker("Edit Data", selection: $selectedDataType) {
					Text("Protobuf").tag(CallDataType.protobuf)
					Text("Messages").tag(CallDataType.message)
				}
				.pickerStyle(.segmented)
			}

			selectedEditorView
		}
		.padding()
	}
}

struct ConfigDetailView: View {
	@ObservedObject var viewModel = ConfigDetailViewModel()
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
			
			ConfigEditView(viewModel: viewModel, config: config!)
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
