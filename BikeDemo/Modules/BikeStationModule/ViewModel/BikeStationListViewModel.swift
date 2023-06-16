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

	private let bikeStationRepository: BikeStationRepositoryProtocol

	init(bikeStationRepository: BikeStationRepositoryProtocol = BikeStationRepository(datasource: BikeStationDatasource())) {
		self.bikeStationRepository = bikeStationRepository
	}

	func fetchBikeStations() async {
		isRefreshing = true
		do {
			let stations = try await bikeStationRepository.fetchBikeStations()
			bikeStations = stations.map { StationViewData(from: $0) }
			errorMessage = nil
		} catch {
			errorMessage = "Error fetching bike stations: \(error.localizedDescription)"
		}
		isRefreshing = false
	}
}
