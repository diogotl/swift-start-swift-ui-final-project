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

    func fetchItems(searchQuery: String = "", page: Int = 1, limit: Int = 12) async throws -> (
        artworks: [Artwork], hasNextPage: Bool
    ) {
        let path: String
        var queryItems: [URLQueryItem] = []

        if !searchQuery.isEmpty {
            path = "artworks/search"
            queryItems.append(URLQueryItem(name: "q", value: searchQuery))
        } else {
            path = "artworks"
        }

        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))

        queryItems.append(
            URLQueryItem(
                name: "fields",
                value:
                    "id,title,artist_title,date_display,place_of_origin,image_id,artwork_type_title,thumbnail"
            ))

        let endpoint = Endpoint(path: path, queryItems: queryItems)

        let response: ArtworkListResponse = try await apiClient.request(endpoint)
        let artworks = response.data.toDomain()

        let hasNextPage: Bool
        if let pagination = response.pagination {
            hasNextPage = pagination.currentPage < pagination.totalPages
        } else {
            hasNextPage = artworks.count == limit
        }

        return (artworks, hasNextPage)
    }
}
