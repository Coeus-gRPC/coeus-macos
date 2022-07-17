//
//  AllReportView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/20/22.
//

import SwiftUI



struct AllReportView: View {
	var body: some View {
		HSplitView {
			
			Collapsible {
				Text("This is collasible")
			} content: {
				VStack {
					Text("Content 1")
					Text("Content 2")
				}

			}

			
//			ConfigSelection
//
//			ConfigDetailView(config: $selected)
//				.frame(minWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

struct AllReportView_Previews: PreviewProvider {
    static var previews: some View {
        AllReportView()
    }
}
