//
//  RootView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = Coordinator()
    @State private var showSplash = true
    private let factory = ViewFactory.makeDefault()

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
        case .home:
            factory.makeHomeView()

        case .favorites:
            factory.makeFavoriteView()

        case .artworkDetail(let artworkId):
            factory.makeArtworkDetailView(artworkId: artworkId)

        case .artistDetail(let artistId):
            factory.makeArtistDetailView(artistId: artistId)
        }
    }
}

#Preview {
    RootView()
}
