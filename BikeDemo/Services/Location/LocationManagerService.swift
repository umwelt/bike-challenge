//
//  LocationManager.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation
import CoreLocation

class LocationManagerService: NSObject, CLLocationManagerDelegate {
	let locationManager = CLLocationManager()
	var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?

	override init() {
		super.init()
		locationManager.delegate = self
	}

	func requestPermission() {
		locationManager.requestWhenInUseAuthorization()
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		onAuthorizationChange?(manager.authorizationStatus)
	}

	func getAuthorizationStatus() -> CLAuthorizationStatus {
		if #available(iOS 14.0, *) {
			return locationManager.authorizationStatus
		} else {
			return CLLocationManager.authorizationStatus()
		}
	}
}
