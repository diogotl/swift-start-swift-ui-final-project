//
//  FavoritesStore.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import Combine
import Foundation

final class FavoritesStore: ObservableObject {
    @Published var favorites: Set<Int> = []

    func favouriteCount() -> Int {
        return self.favorites.count
    }

    func likeArtwork(_ id: Int) {
        let isAlreadyLiked = favorites.contains(id)

        if isAlreadyLiked {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }
}
