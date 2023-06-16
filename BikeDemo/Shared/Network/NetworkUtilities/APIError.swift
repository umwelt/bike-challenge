//
//  APIError.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

enum APIError: Error {
	case noData
	case networkError(Error)
	case decodingError(Error)
	case invalidURL
	case responseError(Int)
}


