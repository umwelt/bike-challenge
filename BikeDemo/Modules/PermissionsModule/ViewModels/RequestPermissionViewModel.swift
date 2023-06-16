//
//  RequestPermissionViewModel.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation
import CoreLocation

class RequestPermissionViewModel: ObservableObject {
	private let locationManagerService = LocationManagerService()
	@Published var isLocationPermissionGranted: Bool = false
	@Published var isPermissionDenied: Bool = false
	@Published var showAlert: Bool = false

	init() {
		locationManagerService.onAuthorizationChange = { [weak self] newStatus in
			self?.handleAuthorizationChange(newStatus: newStatus)
		}
	}

	func requestPermission() {
		let status = locationManagerService.getAuthorizationStatus()
		switch status {
		case .notDetermined:
			locationManagerService.requestPermission()
		case .restricted, .denied:
			isPermissionDenied = true
			showAlert = true
		case .authorizedWhenInUse, .authorizedAlways:
			isLocationPermissionGranted = true
		@unknown default:
			break
		}
	}

	private func handleAuthorizationChange(newStatus: CLAuthorizationStatus) {
		switch newStatus {
		case .authorizedWhenInUse, .authorizedAlways:
			isLocationPermissionGranted = true
		default:
			isLocationPermissionGranted = false
		}
	}
}
