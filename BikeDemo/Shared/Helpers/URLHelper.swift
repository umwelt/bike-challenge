//
//  URLHelper.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import Foundation

struct MapLocationFields {
	static let location = "ll"
}

struct URLHelper {
	static func mapURLForLocation(latitude: Double, longitude: Double) -> URL? {
		var components = URLComponents()
		components.scheme = "http"
		components.host = "maps.apple.com"

		let queryItems = [
			URLQueryItem(name: MapLocationFields.location, value: "\(latitude),\(longitude)")
		]

		components.queryItems = queryItems

		return components.url
	}
}
