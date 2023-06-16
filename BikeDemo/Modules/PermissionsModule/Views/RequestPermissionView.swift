//
//  RequestPermissionView.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import SwiftUI

struct RequestPermissionView: View {
	@EnvironmentObject var viewModel: RequestPermissionViewModel

	struct Strings {
		static let permissionTitle = "We need your permission to access location"
		static let grantPermissionButton = "Grant permission"
		static let permissionDeniedTitle = "Permission Denied"
		static let permissionDeniedMessage = "Location access is required to fetch bike stations data. Please allow the app to access your location in the device settings."
		static let goToSettingsButton = "Go to settings"
	}

	var body: some View {
		VStack {
			Text(Strings.permissionTitle)
				.padding(.bottom, 36)
			Button(action: {
				viewModel.requestPermission()
			}) {
				Text(Strings.grantPermissionButton)
					.foregroundColor(.blue)
					.padding()
					.background(Color.white)
					.cornerRadius(10)
			}
			.buttonStyle(PlainButtonStyle())
		}
		.alert(isPresented: $viewModel.showAlert) {
			Alert(
				title: Text(Strings.permissionDeniedTitle),
				message: Text(Strings.permissionDeniedMessage),
				primaryButton: .default(Text(Strings.goToSettingsButton), action: {
					if let url = URL(string: UIApplication.openSettingsURLString),
					   UIApplication.shared.canOpenURL(url) {
						UIApplication.shared.open(url, options: [:], completionHandler: nil)
					}
				}),
				secondaryButton: .cancel()
			)
		}
	}
}
