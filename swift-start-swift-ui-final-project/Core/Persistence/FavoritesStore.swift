//
//  FavoritesStore.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import Combine
import Foundation

final class FavoritesStore: ObservableObject {
    @Published var favorites: Set<Int>
    var count: Int { favorites.count }

    init() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
            let decoded = try? JSONDecoder().decode([Int].self, from: data)
        {
            self.favorites = Set(decoded)
        } else {
            self.favorites = []
        }
    }

    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(id)
    }

    func toggleFavorite(_ id: Int) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(Array(favorites)) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }
}
