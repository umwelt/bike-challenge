//
//  BikeStationListViewModel.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import Foundation
import CoreLocation

@MainActor
class BikeStationListViewModel: ObservableObject {
	@Published var bikeStations: [StationViewData] = []
	@Published var isRefreshing = false
	@Published var errorMessage: String?

	private let bikeStationRepository: BikeStationRepositoryProtocol
	private var isFetching = false

	private let locationManagerService = LocationManagerService()

	init(bikeStationRepository: BikeStationRepositoryProtocol = BikeStationRepository(datasource: BikeStationDatasource())) {
		self.bikeStationRepository = bikeStationRepository

		locationManagerService.onLocationChange = { [weak self] location in
			self?.sortStationsByDistance(from: location)
		}
		locationManagerService.requestPermission()

		if locationManagerService.locationManager.authorizationStatus == .authorizedWhenInUse ||
			locationManagerService.locationManager.authorizationStatus == .authorizedAlways {
			locationManagerService.startUpdatingLocation()
		}
	}


	private func sortStationsByDistance(from userLocation: CLLocation) {
		bikeStations.sort { (station1, station2) -> Bool in
			let location1 = CLLocation(latitude: station1.latitude, longitude: station1.longitude)
			let location2 = CLLocation(latitude: station2.latitude, longitude: station2.longitude)
			return userLocation.distance(from: location1) < userLocation.distance(from: location2)
		}
	}

	private func sortStationsByName() {
		bikeStations.sort { (station1, station2) -> Bool in
			return station1.name < station2.name
		}
	}

	func fetchBikeStations() async {
		guard !isRefreshing && !isFetching else { return }
		isRefreshing = true
		isFetching = true
		defer {
			Task {
				isRefreshing = false
				isFetching = false
			}
		}
		do {
			let stations = try await bikeStationRepository.fetchBikeStations()
			Task {
				bikeStations = stations.map { StationViewData(from: $0) }
				errorMessage = nil

				if locationManagerService.locationManager.authorizationStatus == .authorizedWhenInUse ||
					locationManagerService.locationManager.authorizationStatus == .authorizedAlways {
					if let location = locationManagerService.locationManager.location {
						self.sortStationsByDistance(from: location)
					}
				} else {
					// If location permissions were denied or not asked, sort by name
					self.bikeStations.sort { $0.name < $1.name }
				}
			}
		} catch {
			Task {
				errorMessage = "Error fetching bike stations: \(error.localizedDescription)"
			}
		}
	}
}
