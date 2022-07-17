//
//  DetailColumn.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/4/22.
//

import SwiftUI

struct DetailColumn: View {
	@Binding var selection: SidebarItem
	
	var body: some View {
		switch selection {
		case .endpointsSend:
			SendView()
		case .endpointsAdd:
			ConfigAddView()
		case .reportsAll:
			AllReportView()
		case .reportsNew:
			SampleView()
		}
	}
}

