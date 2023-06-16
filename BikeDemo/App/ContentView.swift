//
//  ContentView.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var permissionVM = RequestPermissionViewModel()

	var body: some View {
		if permissionVM.isLocationPermissionGranted {
			BikeStationListView()
		} else {
			RequestPermissionView()
				.environmentObject(permissionVM)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
