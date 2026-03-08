//
//  RootView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = Coordinator()
    @StateObject private var favoritesStore = FavoritesStore()
    @State private var showSplash = true

    private var factory: ViewFactory {
        ViewFactory.makeDefault(favoritesStore: favoritesStore)
    }

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                NavigationStack(path: $coordinator.path) {
                    factory.makeMainTabView()
                        .navigationDestination(for: Route.self) { route in
                            destinationView(for: route)
                        }
                }
            }
        }
        .environmentObject(coordinator)
        .environmentObject(favoritesStore)
        .task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
                showSplash = false
            }
        }
    }

    @ViewBuilder
    private func destinationView(for route: Route) -> some View {
        switch route {
        case .artworkDetail(let artworkId):
            factory.artworkDetailViewFactory.makeArtworkDetailView(artworkId: artworkId)

        case .artistDetail(let artistId):
            factory.artistDetailViewFactory.makeArtistDetailView(artistId: artistId)
        }
    }
}

#Preview {
    RootView()
}
