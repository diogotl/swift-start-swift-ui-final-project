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
}
