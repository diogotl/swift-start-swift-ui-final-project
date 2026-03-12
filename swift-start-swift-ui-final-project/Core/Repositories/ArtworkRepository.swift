//
//  ArtworkRepository.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

final class ArtworkRepository: ArtworkRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchArtworks(page: Int, limit: Int, query: String?) async throws -> (
        artworks: [Artwork], hasNextPage: Bool
    ) {
        let path: String
        var queryItems: [URLQueryItem] = []

        if let query = query, !query.isEmpty {
            path = "artworks/search"
            queryItems.append(URLQueryItem(name: "q", value: query))
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
            )
        )

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

    func fetchArtwork(id: Int) async throws -> Artwork {
        let endpoint = Endpoint(path: "artworks/\(id)", queryItems: nil)
        let response: ArtworkDetailResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }

    func fetchArtworksByIds(_ ids: [Int]) async throws -> [Artwork] {
        guard !ids.isEmpty else { return [] }

        let idsString = ids.map(String.init).joined(separator: ",")
        let queryItems = [
            URLQueryItem(name: "ids", value: idsString),
            URLQueryItem(
                name: "fields",
                value: "id,title,artist_title,date_display,image_id,thumbnail"
            ),
        ]

        let endpoint = Endpoint(path: "artworks", queryItems: queryItems)
        let response: ArtworkListResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }
}
