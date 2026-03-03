//
//  ViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class ViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    static func makeDefault() -> ViewFactory {
        // TODO: reworking
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        let apiClient = APIClient(baseURL: baseUrl)
        return ViewFactory(apiClient: apiClient)
    }

    func makeMainTabView() -> MainTabView {
        return MainTabView()
    }

    func makeHomeView() -> HomeView {
        let service = HomeViewService(apiClient: apiClient)
        let viewModel = HomeViewModel(service: service)
        return HomeView(viewModel: viewModel)
    }

    func makeFavoriteView() -> FavoriteView {
        return FavoriteView()
    }

    func makeArtworkDetailView(artworkId: Int) -> ArtworkDetailView {
        let service = ArtworkDetailService(apiClient: apiClient)
        let viewModel = ArtworkDetailViewModel(
            service: service,
            artworkId: artworkId
        )
        return ArtworkDetailView(viewModel: viewModel)
    }

    func makeArtistDetailView(artistId: Int) -> ArtistDetailView {
        let service = ArtistDetailViewService(apiClient: apiClient)
        let viewModel = ArtistDetailViewModel(
            service: service,
            artistId: artistId
        )
        return ArtistDetailView(viewModel: viewModel)
    }
}
