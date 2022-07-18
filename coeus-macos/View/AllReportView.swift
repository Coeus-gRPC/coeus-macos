//
//  AllReportView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/20/22.
//

import SwiftUI

struct ReportDetailView: View {
	@Binding var report: CoeusReport
	
	var body: some View {
		if report.totalCallNum != -1 {
			ReportVisualizationView()
		} else {
			NoSelectionPlaceholderView(.report)
		}
	}
}

struct AllReportView: View {
	@State var selectedReport: CoeusReport
	
	init() {
		self._selectedReport = State(initialValue: CoeusReport.NewDummyReport())
	}
	
	var ReportSelectView: some View {
		Collapsible {
			Text("This is collasible")
		} content: {
			VStack {
				Text("Content 1")
				Text("Content 2")
			}
		}
	}
	
	var body: some View {
		HSplitView {
			ReportSelectView

			ReportDetailView(report: $selectedReport)
				.frame(minWidth: 550, maxWidth: .infinity, maxHeight: .infinity)
		}
	}
}

struct AllReportView_Previews: PreviewProvider {
    static var previews: some View {
			AllReportView()
    }
}
