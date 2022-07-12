//
//  NoSelectionPlaceholderView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/11/22.
//

import SwiftUI

struct NoSelectionPlaceholderView: View {
		var body: some View {
				VStack(alignment: .center, spacing: 16) {
						Text("No configuration selected")
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

