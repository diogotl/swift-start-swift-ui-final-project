//
//  ArtworkDetailViewService.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import Foundation

final class ArtworkDetailService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchArtworkDetail(id: Int) async throws -> Artwork {
        let endpoint = Endpoint(path: "artworks/\(id)", queryItems: nil)

        print("endpoint", endpoint)

        let response: ArtworkDetailResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }
}
