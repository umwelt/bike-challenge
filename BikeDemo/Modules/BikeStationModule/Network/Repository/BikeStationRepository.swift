//
//  BikeStationRepository.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

protocol BikeStationRepositoryProtocol {
	func fetchBikeStations() async throws -> [Station]
}

class BikeStationRepository: BikeStationRepositoryProtocol {
	let datasource: BikeStationDatasourceProtocol

	init(datasource: BikeStationDatasourceProtocol) {
		self.datasource = datasource
	}

	func fetchBikeStations() async throws -> [Station] {
		let networkResponse = try await datasource.fetchBikeStations()
		return networkResponse.network.stations
	}
}
