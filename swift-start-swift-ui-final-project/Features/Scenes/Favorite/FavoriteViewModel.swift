//
//  FavoriteViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import Combine
import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {

    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: FavoriteViewService
    private let favoritesStore: FavoritesStore

    init(service: FavoriteViewService, favoritesStore: FavoritesStore) {
        self.service = service
        self.favoritesStore = favoritesStore
    }

    func loadFavorites() async {
        let favoriteIds = Array(favoritesStore.favorites)

        guard !favoriteIds.isEmpty else {
            artworks = []
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let fetchedArtworks = try await service.fetchArtworks(ids: favoriteIds)
            artworks = fetchedArtworks
        } catch {
            errorMessage = "failed to load"
            artworks = []
        }

        isLoading = false
    }
}
