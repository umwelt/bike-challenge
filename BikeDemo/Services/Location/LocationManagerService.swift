//
//  LocationManager.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import CoreLocation

class LocationManagerService: NSObject, CLLocationManagerDelegate {
	let locationManager = CLLocationManager()
	var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?
	var onLocationChange: ((CLLocation) -> Void)?

	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}

	func requestPermission() {
		locationManager.requestWhenInUseAuthorization()
	}

	func startUpdatingLocation() {
		locationManager.startUpdatingLocation()
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		onAuthorizationChange?(manager.authorizationStatus)
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			onLocationChange?(location)
		}
	}

	func getAuthorizationStatus() -> CLAuthorizationStatus {
		if #available(iOS 14.0, *) {
			return locationManager.authorizationStatus
		} else {
			return CLLocationManager.authorizationStatus()
		}
	}
}
