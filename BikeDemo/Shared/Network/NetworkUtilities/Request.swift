//
//  Request.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

struct Request {
	let endpoint: String
	let method: HTTPMethod
	let parameters: [String: String]?
}
