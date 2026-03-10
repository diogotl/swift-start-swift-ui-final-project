//
//  MainTabView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 28/02/2026.
//

import SwiftUI

struct MainTabView: View {
    private let viewFactory: ViewFactory

    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    var body: some View {
        TabView {
            viewFactory.discoverViewFactory.makeDiscoverView()
                .tabItem {
                    Label(String(localized: "tab.discover"), systemImage: "sparkles")
                }

            viewFactory.homeViewFactory.makeHomeView()
                .tabItem {
                    Label(String(localized: "tab.collection"), systemImage: "square.grid.2x2")
                }

            viewFactory.favoriteViewFactory.makeFavoriteView()
                .tabItem {
                    Label(String(localized: "tab.favourites"), systemImage: "heart")
                }
        }
        .accentColor(Colors.brown500)
    }
}
