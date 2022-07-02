//
//  SendView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/1/22.
//

import SwiftUI

struct SendView: View {
	var body: some View {
		List {
			ForEach(CoeusConfigService.shared.configFiles) { config in
				Text(config.id!.uuidString)
			}
		}
	}
}

struct SendView_Previews: PreviewProvider {
	static var previews: some View {
		SendView()
	}
}
