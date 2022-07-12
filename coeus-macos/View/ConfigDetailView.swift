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

struct ConfigEditView: View {
	@ObservedObject var viewModel: ConfigDetailViewModel
	@State private var selectedDataType: CallDataType = .protobuf
	@Binding var config: CoeusConfig
	@State var text: String = ""
	var language: CodeEditor.Language = .swift
	
	init(viewModel: ConfigDetailViewModel, config: Binding<CoeusConfig>) {
		self.viewModel = viewModel
		_config = config
		
		_text = State(initialValue: viewModel.readCallData(selectedDataType, config.wrappedValue))
	}

	var body: some View {
		VStack {
			Form {
				Section() {
					Picker("Edit Data", selection: $selectedDataType) {
						Text("Protobuf").tag(CallDataType.protobuf)
						Text("Messages").tag(CallDataType.message)
					}
					.pickerStyle(.segmented)
				}
				
				VStack {
					HStack {
						Spacer()
						Button {
							self.config = viewModel.updateCallData(selectedDataType, config, text)
						} label: {
							Text("Save")
						}
						.standardButton()
					}

					CodeEditor(source: $text, language: language, theme: .init(rawValue: "xcode"))
				}
		}
		}
		.padding()
	}
}

struct ConfigEditSection: View {
	@ObservedObject var viewModel: ConfigDetailViewModel
	@State var responseText = "Invoke above methods to display a response"
	@Binding var config: CoeusConfig

	init(_ config: Binding<CoeusConfig>, _ viewModel: ConfigDetailViewModel) {
		self._config = config
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

					Spacer()
					InvokeButton
				}.padding()
				
				ConfigEditView(viewModel: viewModel, config: $config)
			}
				.frame(maxWidth: .infinity, minHeight: 350, maxHeight: .infinity)
			
			RemoteCallResponseSection
				.frame(maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
		}
	}
}

struct ConfigDetailView: View {
	@ObservedObject var viewModel = ConfigDetailViewModel()
	@Binding var config: CoeusConfig

	var body: some View {
		if config.id != nil {
			ConfigEditSection($config, viewModel)
				.frame(minHeight: 250, idealHeight: 600)
		} else {
			NoSelectionPlaceholderView()
		}
	}
}
