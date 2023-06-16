//
//  StationViewData.swift
//  BikeMap
//
//  Created by Hugo Perez on 16/6/23.
//

import Foundation

struct StationViewData {
	let id: String
	let name: String
	let freeBikes: Int
	let emptySlots: Int
	let latitude: Double
	let longitude: Double

	init(from station: Station) {
		self.id = station.id
		self.name = station.name
		self.freeBikes = station.freeBikes
		self.emptySlots = station.emptySlots ?? 0
		self.latitude = station.latitude
		self.longitude = station.longitude
	}
}
