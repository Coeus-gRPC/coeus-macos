//
//  NoSelectionPlaceholderView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/11/22.
//

import SwiftUI

enum SelectionType: String {
	case config = "Configuration"
	case report = "Report"
}

struct NoSelectionPlaceholderView: View {
	@State var selectionType: SelectionType
	
	init(_ selectionType: SelectionType) {
		self.selectionType = selectionType
	}
	
	var body: some View {
		VStack(alignment: .center, spacing: 16) {
			Text("No \(selectionType.rawValue) Selected")
				.font(.headline)
				.fontWeight(.bold)
			Image(systemName: "lightbulb.slash")
				.bold()
		}
			.frame(minWidth: 500,
				maxWidth: .infinity,
				maxHeight: .infinity)
	}
}

