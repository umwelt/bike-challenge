//
//  APIClient.swift
//  BikeMap
//
//  Created by Hugo Perez on 15/6/23.
//

import Foundation

protocol APIClientProtocol {
	func fetch<T: Decodable>(type: T.Type, request: Request) async throws -> T
}

class APIClient: APIClientProtocol {
	private let urlSession: URLSession

	init(urlSession: URLSession = .shared) {
		self.urlSession = urlSession
	}

	func fetch<T: Decodable>(type: T.Type, request: Request) async throws -> T {
		guard var urlComponents = URLComponents(string: request.endpoint) else {
			throw APIError.invalidURL
		}

		if let parameters = request.parameters {
			urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		}

		guard let url = urlComponents.url else {
			throw APIError.invalidURL
		}
		

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue

		let (data, response) = try await urlSession.data(for: urlRequest)
		guard let httpResponse = response as? HTTPURLResponse,
			  (200..<300).contains(httpResponse.statusCode) else {
			throw APIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
		}

		let decodedObject = try JSONDecoder().decode(T.self, from: data)

		return decodedObject
	}
}
