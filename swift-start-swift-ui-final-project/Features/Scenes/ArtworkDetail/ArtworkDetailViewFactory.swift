//
//  ArtworkDetailViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class ArtworkDetailViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func makeArtworkDetailView(artworkId: Int) -> ArtworkDetailView {
        let service = ArtworkDetailService(apiClient: apiClient)
        let viewModel = ArtworkDetailViewModel(
            service: service,
            artworkId: artworkId
        )
        return ArtworkDetailView(viewModel: viewModel)
    }
}
