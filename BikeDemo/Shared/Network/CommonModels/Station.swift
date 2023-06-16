//
//  Station.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

struct Station: Codable, Identifiable {
	let id: String
	let emptySlots: Int?
	let extra: Extra
	let freeBikes: Int
	let latitude: Double
	let longitude: Double
	let name: String
	let timestamp: String

	enum CodingKeys: String, CodingKey {
		case id
		case emptySlots = "empty_slots"
		case extra
		case freeBikes = "free_bikes"
		case latitude
		case longitude
		case name
		case timestamp
	}
}

