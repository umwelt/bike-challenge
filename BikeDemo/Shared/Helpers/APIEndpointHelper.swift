//
//  APIEndpointHelper.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import Foundation

struct StationFields {
	static let id = "stations.id"
	static let name = "stations.name"
	static let freeBikes = "stations.free_bikes"
	static let emptySlots = "stations.empty_slots"
	static let latitude = "stations.latitude"
	static let longitude = "stations.longitude"
}

struct APIEndpointHelper {
	static func networkEndpointURL() -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.citybik.es"
		components.path = "/v2/networks/wienmobil-rad"

		let fieldNames = [
			StationFields.id,
			StationFields.name,
			StationFields.freeBikes,
			StationFields.emptySlots,
			StationFields.latitude,
			StationFields.longitude
		]

		let queryItems = [
			URLQueryItem(name: "fields", value: fieldNames.joined(separator: ","))
		]

		components.queryItems = queryItems

		return components.url
	}
}

