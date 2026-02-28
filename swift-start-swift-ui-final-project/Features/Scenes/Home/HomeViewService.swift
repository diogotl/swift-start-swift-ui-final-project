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

    func fetchItems() async throws -> ArtworkResponse {
        let endpoint = Endpoint(path: "artworks", queryItems: nil)
        
        print("endpoint", endpoint)
        
        return try await apiClient.request(endpoint)
    }
}
