//
//  ViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class ViewFactory {
    let discoverViewFactory: DiscoverViewFactory
    let homeViewFactory: HomeViewFactory
    let favoriteViewFactory: FavoriteViewFactory
    let artworkDetailViewFactory: ArtworkDetailViewFactory
    let artistDetailViewFactory: ArtistDetailViewFactory

    init(apiClient: APIClient, favoritesStore: FavoritesStore) {
        self.discoverViewFactory = DiscoverViewFactory(apiClient: apiClient)
        self.homeViewFactory = HomeViewFactory(apiClient: apiClient)
        self.favoriteViewFactory = FavoriteViewFactory(
            apiClient: apiClient, favoritesStore: favoritesStore)
        self.artworkDetailViewFactory = ArtworkDetailViewFactory(apiClient: apiClient)
        self.artistDetailViewFactory = ArtistDetailViewFactory(apiClient: apiClient)
    }

    static func makeDefault(favoritesStore: FavoritesStore) -> ViewFactory {
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        let apiClient = APIClient(baseURL: baseUrl)
        return ViewFactory(apiClient: apiClient, favoritesStore: favoritesStore)
    }

    func makeMainTabView() -> MainTabView {
        return MainTabView(viewFactory: self)
    }
}
