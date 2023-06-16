//
//  MockAPIClient.swift
//  BikeMapTests
//
//  Created by Hugo Perez on 16/6/23.
//

import XCTest
@testable import BikeMap

class MockAPIClient: APIClientProtocol {
	var fetchResult: Result<Decodable, APIError>?

	func fetch<T: Decodable>(type: T.Type, request: Request, completion: @escaping (Result<T, APIError>) -> Void) {
		if let fetchResult = fetchResult as? Result<T, APIError> {
			completion(fetchResult)
		} else {
			completion(.failure(.noData))
		}
	}
}
