//
//  HomeViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class HomeViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func makeHomeView() -> HomeView {
        let artworkRepository = ArtworkRepository(apiClient: apiClient)
        let viewModel = HomeViewModel(artworkRepository: artworkRepository)
        return HomeView(viewModel: viewModel)
    }
}
