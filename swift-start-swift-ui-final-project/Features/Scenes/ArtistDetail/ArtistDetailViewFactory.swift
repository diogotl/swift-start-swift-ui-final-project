//
//  ArtistDetailViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class ArtistDetailViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func makeArtistDetailView(artistId: Int) -> ArtistDetailView {
        let artistRepository = ArtistRepository(apiClient: apiClient)
        let viewModel = ArtistDetailViewModel(
            artistRepository: artistRepository,
            artistId: artistId
        )
        return ArtistDetailView(viewModel: viewModel)
    }
}
