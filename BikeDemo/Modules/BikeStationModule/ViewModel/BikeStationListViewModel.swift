//
//  BikeStationListViewModel.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import Foundation

@MainActor
class BikeStationListViewModel: ObservableObject {
	@Published var bikeStations: [StationViewData] = []
	@Published var isRefreshing = false
	@Published var errorMessage: String?

	private let bikeStationDatasource: BikeStationDatasourceProtocol

	init(bikeStationDatasource: BikeStationDatasourceProtocol = BikeStationDatasource()) {
		self.bikeStationDatasource = bikeStationDatasource
	}

	func fetchBikeStations() async throws {
		isRefreshing = true
		do {
			let networkResponse = try await bikeStationDatasource.fetchBikeStations()
			bikeStations = networkResponse.network.stations.map { StationViewData(from: $0) }
			errorMessage = nil
		} catch {
			errorMessage = "Error fetching bike stations: \(error.localizedDescription)"
			throw error
		}
		isRefreshing = false
	}
}
