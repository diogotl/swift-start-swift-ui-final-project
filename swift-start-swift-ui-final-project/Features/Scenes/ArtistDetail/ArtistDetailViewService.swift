//
//  ArtistDetailViewService.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

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
}
