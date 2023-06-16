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
	private var isFetching = false

	init(bikeStationRepository: BikeStationRepositoryProtocol = BikeStationRepository(datasource: BikeStationDatasource())) {
		self.bikeStationRepository = bikeStationRepository
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
			}
		} catch {
			Task {
				errorMessage = "Error fetching bike stations: \(error.localizedDescription)"
			}
		}
	}
}
