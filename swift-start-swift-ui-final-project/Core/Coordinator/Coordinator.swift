//
//  Coordinator.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import Combine
import SwiftUI

@MainActor
final class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }

    func popTo(_ count: Int) {
        guard path.count >= count else { return }
        path.removeLast(count)
    }

    func navigateToArtworkDetail(artworkId: Int) {
        push(.artworkDetail(artworkId: artworkId))
    }

    func navigateToArtistDetail(artistId: Int) {
        push(.artistDetail(artistId: artistId))
    }

    func navigateToHome() {
        push(.home)
    }

    func navigateToFavorites() {
        push(.favorites)
    }
}
