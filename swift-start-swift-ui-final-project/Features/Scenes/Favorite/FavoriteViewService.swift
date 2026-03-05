//
//  FavoriteViewService.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import Foundation

final class FavoriteViewService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchArtworks(ids: [Int]) async throws -> [Artwork] {
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
