//
//  Extra.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

struct Extra: Codable {
	let bikeUIDs: [String]
	let number: String
	let slots: Int?
	let uid: String

	enum CodingKeys: String, CodingKey {
		case bikeUIDs = "bike_uids"
		case number
		case slots
		case uid
	}
}
