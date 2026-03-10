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
    @State private var factory: ViewFactory?

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else if let factory {
                NavigationStack(path: $coordinator.path) {
                    factory.makeMainTabView()
                        .navigationDestination(for: Route.self) { route in
                            destinationView(for: route, factory: factory)
                        }
                }
            }
        }
        .environmentObject(coordinator)
        .environmentObject(favoritesStore)
        .onAppear {
            if factory == nil {
                factory = ViewFactory.makeDefault(favoritesStore: favoritesStore)
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            withAnimation {
                showSplash = false
            }
        }
    }

    @ViewBuilder
    private func destinationView(for route: Route, factory: ViewFactory) -> some View {
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
