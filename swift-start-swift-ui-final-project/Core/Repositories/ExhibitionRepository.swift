//
//  ExhibitionRepository.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

final class ExhibitionRepository: ExhibitionRepositoryProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchExhibitions(limit: Int = 10) async throws -> [Exhibition] {
        let queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(
                name: "fields",
                value:
                    "id,title,short_description,image_url,status,aic_start_at,aic_end_at,gallery_title,web_url"
            ),
        ]

        let endpoint = Endpoint(path: "exhibitions", queryItems: queryItems)
        let response: ExhibitionListResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }

    func fetchExhibition(id: Int) async throws -> Exhibition {
        let queryItems = [
            URLQueryItem(
                name: "fields",
                value:
                    "id,title,short_description,image_url,status,aic_start_at,aic_end_at,gallery_title,web_url"
            )
        ]

        let endpoint = Endpoint(path: "exhibitions/\(id)", queryItems: queryItems)
        let response: ExhibitionDetailResponse = try await apiClient.request(endpoint)
        return response.data.toDomain()
    }
}
