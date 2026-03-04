//
//  ViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class ViewFactory {
    let homeViewFactory: HomeViewFactory
    let favoriteViewFactory: FavoriteViewFactory
    let artworkDetailViewFactory: ArtworkDetailViewFactory
    let artistDetailViewFactory: ArtistDetailViewFactory

    init(apiClient: APIClient) {
        self.homeViewFactory = HomeViewFactory(apiClient: apiClient)
        self.favoriteViewFactory = FavoriteViewFactory()
        self.artworkDetailViewFactory = ArtworkDetailViewFactory(apiClient: apiClient)
        self.artistDetailViewFactory = ArtistDetailViewFactory(apiClient: apiClient)
    }

    static func makeDefault() -> ViewFactory {
        // TODO: reworking
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        let apiClient = APIClient(baseURL: baseUrl)
        return ViewFactory(apiClient: apiClient)
    }

    func makeMainTabView() -> MainTabView {
        return MainTabView(viewFactory: self)
    }
}
