//
//  FavoriteViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class FavoriteViewFactory {
    private let apiClient: APIClient
    private let favoritesStore: FavoritesStore

    init(apiClient: APIClient, favoritesStore: FavoritesStore) {
        self.apiClient = apiClient
        self.favoritesStore = favoritesStore
    }

    func makeFavoriteView() -> FavoriteView {
        let service = FavoriteViewService(apiClient: apiClient)
        let viewModel = FavoriteViewModel(
            service: service,
            favoritesStore: favoritesStore
        )
        return FavoriteView(viewModel: viewModel)
    }
}
