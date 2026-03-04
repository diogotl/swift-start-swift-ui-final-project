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
        HStack {
            TabView {
                viewFactory.homeViewFactory.makeHomeView()
                    .tabItem {
                        Label("Collection", systemImage: "square.grid.2x2.fill")
                    }
                viewFactory.favoriteViewFactory.makeFavoriteView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
            .accentColor(Colors.brown500)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {

                }
            }
        }
    }
}
