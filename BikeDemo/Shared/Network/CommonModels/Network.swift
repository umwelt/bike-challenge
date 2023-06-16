//
//  Network.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

struct Network: Codable {
	let company: [String]?
	let href: String?
	let id: String
	let location: Location?
	let name: String
	let stations: [Station]
}
