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
	@State var text: String
	@State var config: CoeusConfig
	var editorType: CallDataType
	var language: CodeEditor.Language = .swift

	init(viewModel: ConfigDetailViewModel, config: CoeusConfig, editorType: CallDataType) {
		self.viewModel = viewModel
		self.editorType = editorType
		_config = State(initialValue: config)
		_text = State(initialValue: viewModel.readCallData(editorType, config))
	}
	
	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					self.config = viewModel.updateCallData(editorType, config, text)
				} label: {
					Text("Save")
				}
				.standardButton()
			}
			
			CodeEditor(source: $text, language: language, theme: .init(rawValue: "xcode"))
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
			CallDataEditView(viewModel: viewModel, config: config, editorType: .message)
		case .protobuf:
			CallDataEditView(viewModel: viewModel, config: config, editorType: .protobuf)
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
				.onDisappear {
					
				}
		}
		.padding()
	}
}

struct ConfigEditSection: View {
	@ObservedObject var viewModel: ConfigDetailViewModel
	@State var responseText = "Invoke above methods to display a response"
	@State var config: CoeusConfig

	init(_ config: CoeusConfig, _ viewModel: ConfigDetailViewModel) {
		self._config = State(initialValue: config)
		self.viewModel = viewModel
	}
	
	
	var RemoteCallResponseSection: some View {
		Text(responseText)
	}
	
	var InvokeButton: some View {
		Button {
			self.responseText = BinaryCallService.shared.InvokeRPC(config)
		} label: {
			Image(systemName: "paperplane")
		}
	}
	
	var body: some View {
		VSplitView {
			VStack {
				HStack {
					TextField("Wulala", text: $config.targetHost)
					Text(config.targetHost).bold().font(.title)
					Spacer()
					InvokeButton
				}.padding()
				
				ConfigEditView(viewModel: viewModel, config: config)
			}
				.frame(maxWidth: .infinity, minHeight: 350, maxHeight: .infinity)
			
			RemoteCallResponseSection
				.frame(maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
		}
	}
}

struct ConfigDetailView: View {
	@ObservedObject var viewModel = ConfigDetailViewModel()
	@Binding var config: CoeusConfig?

	var body: some View {
		if config != nil {
			ConfigEditSection(config!, viewModel)
				.frame(minHeight: 250, idealHeight: 600)
		} else {
			Text("Please Select a config")
		}
	}
}
