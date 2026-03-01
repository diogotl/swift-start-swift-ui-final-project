//
//  HomeViewService.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 28/02/2026.
//

import Foundation

final class HomeViewService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchItems(searchQuery: String = "") async throws -> [Artwork] {
        let path: String
        var queryItems: [URLQueryItem]? = nil

        if !searchQuery.isEmpty {
            path = "artworks/search"
            queryItems = [URLQueryItem(name: "q", value: searchQuery)]
        } else {
            path = "artworks"
        }

        let endpoint = Endpoint(path: path, queryItems: queryItems)

        print("endpoint", endpoint)

        let response: ArtworkListResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }
}
