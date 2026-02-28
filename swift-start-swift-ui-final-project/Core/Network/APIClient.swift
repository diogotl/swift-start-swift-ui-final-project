//
//  APIClient.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 28/02/2026.
//

import Foundation

final class APIClient {

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {

        guard var components = URLComponents(string: baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        // Perform network request and convert network errors to APIError.network
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw APIError.network(error)
        }

        // Validate HTTP response status code
        guard let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode
        else {
            throw APIError.invalidResponse
        }

        // Decode payload
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw APIError.decodingError
        }
    }
}
