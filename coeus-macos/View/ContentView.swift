//
//  ContentView.swift
//  coeus-macos
//
//  Created by Yifan Huang on 7/4/22.
//

import SwiftUI

enum SidebarItem: Hashable {
	case endpointsSend
	case endpointsAdd
	case reportsAll
	case reportsNew
}

struct SampleView: View {
	var body: some View {
		Text("Sample View")
	}
}

struct ContentView: View {
	@State private var selection: SidebarItem = .endpointsSend
	@State private var path = NavigationPath()
	
	var body: some View {
		NavigationSplitView {
			Sidebar(selection: $selection)
		} detail: {
			NavigationStack(path: $path) {
					DetailColumn(selection: $selection)
			}
		}
		.onChange(of: selection) { _ in
				path.removeLast(path.count)
		}
		.frame(minWidth: 600, minHeight: 450)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
