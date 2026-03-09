//
//  ArtistDetailViewService.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import Foundation

final class ArtistDetailViewService {
    private let apiClient: APIClient
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchArtist(id: Int) async throws -> Artist {
        let endpoint = Endpoint(path: "artists/\(id)", queryItems: nil)

        print("endpoint", endpoint)

        let response: ArtistDetailResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }

    func fetchArtistArtworks(artistId: Int, page: Int = 1, limit: Int = 12) async throws
        -> (artworks: [Artwork], hasNextPage: Bool)
    {
        let queryItems = [
            URLQueryItem(name: "q", value: "artist_ids:\(artistId)"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(
                name: "fields",
                value: "id,title,image_id,artist_title,date_display,artwork_type_title"),
        ]

        let endpoint = Endpoint(path: "artworks/search", queryItems: queryItems)
        let response: ArtworkListResponse = try await apiClient.request(endpoint)
        let artworks = response.data.map { $0.toDomain() }

        let hasNextPage: Bool
        if let pagination = response.pagination {
            hasNextPage = pagination.currentPage < pagination.totalPages
        } else {
            hasNextPage = artworks.count == limit
        }

        return (artworks, hasNextPage)
    }
}
