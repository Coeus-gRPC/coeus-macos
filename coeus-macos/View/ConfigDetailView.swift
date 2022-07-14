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
	@State var language: CodeEditor.Language = .swift
	
	init(viewModel: ConfigDetailViewModel, config: Binding<CoeusConfig>) {
		self.viewModel = viewModel
		_config = config
		
		_text = State(initialValue: viewModel.readCallData(selectedDataType, config.wrappedValue))
		_language = State(initialValue: viewModel.setCodeEditorLanguage(selectedDataType))
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
		.onChange(of: selectedDataType, perform: { newSelection in
			text = viewModel.readCallData(newSelection, config)
			language = viewModel.setCodeEditorLanguage(selectedDataType)
		})
		.onChange(of: config, perform: { newConfig in
			text = viewModel.readCallData(selectedDataType, newConfig)
			language = viewModel.setCodeEditorLanguage(selectedDataType)
		})
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
			CoeusReportService.shared.prepareOutput(&config)
			print("Well, the new report path is:\(config.outputFilePath)")
			CoeusConfigService.shared.updateConfigFile(config)
			self.responseText = BinaryCallService.shared.InvokeRPC(config)
		} label: {
			Image(systemName: "paperplane")
		}
	}
	
	var ConfigSettings: some View {
		Grid {
			GridRow {
				// Target Host
				HStack {
					Text("Taget Host: ")
					TextField("", text: $config.targetHost)
						.font(.title)
				}
				
				// Call Number
				HStack {
					Text("Total Call Count: ")
					TextField("", text: Binding(
						get: { String(config.totalCallNum )},
						set: {config.totalCallNum = Int($0) ?? 0}
					))
						.font(.title2)
				}
			}
			
			GridRow {
				HStack {
					Text("Concurrent Count: ")
					TextField("", text: Binding(
						get: { String(config.concurrent )},
						set: {config.concurrent = Int($0) ?? 1}
					))
						.font(.title2)
				}
				
				HStack {
					Text("Method Name: ")
					TextField("", text: $config.methodName)
						.font(.title2)
				}
			}
			
			GridRow {
				HStack {
					Text("Timout: ")
					TextField("", text: Binding(
						get: { String(config.timeout )},
						set: {config.timeout = Int($0) ?? 500}
					))
						.font(.title2)
					Text("ms")
				}
				
				Toggle("Insecure", isOn: $config.insecure)
						.toggleStyle(.checkbox)
			}
			
		}
	}
	
	var body: some View {
		VSplitView {
			VStack {
				HStack {
					ConfigSettings
						.onChange(of: config, perform: { newConfig in
							print("on change")
							CoeusConfigService.shared.updateConfigFile(config)
						})
						.onSubmit {
							print("Submitting...?")
							CoeusConfigService.shared.updateConfigFile(config)
						}
						.onDisappear {
							print("Submitting...?/ disappear")
							CoeusConfigService.shared.updateConfigFile(config)
						}
					
					Spacer()
						.frame(width: 25)
					
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
		if config.targetHost != "" {
			ConfigEditSection($config, viewModel)
				.frame(minHeight: 250, idealHeight: 600)
		} else {
			NoSelectionPlaceholderView()
		}
	}
}
