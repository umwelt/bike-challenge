//
//  BikeStationDatasource.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

protocol BikeStationDatasourceProtocol {
	func fetchBikeStations() async throws -> NetworkResponse
}

class BikeStationDatasource: BikeStationDatasourceProtocol {
	let apiClient: APIClientProtocol

	init(apiClient: APIClientProtocol = APIClient()) {
		self.apiClient = apiClient
	}

	func fetchBikeStations() async throws -> NetworkResponse {
		guard let endpointURL = APIEndpointHelper.networkEndpointURL() else {
			throw APIError.invalidURL
		}

		let endpoint = Request(endpoint: endpointURL.absoluteString, method: .get, parameters: nil)

		return try await apiClient.fetch(type: NetworkResponse.self, request: endpoint)
	}
}
