//
//  FavoriteView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel: FavoriteViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var favoritesStore: FavoritesStore

    init(viewModel: FavoriteViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: Spacing.medium) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(localized: "favorites.header.title"))
                            .font(Typography.headingMd)
                        Text(
                            String(localized: "\(favoritesStore.count) favourite artworks")
                        )
                        .font(Typography.bodySm)
                        .foregroundStyle(Colors.neutral500)
                    }
                    Spacer()
                }
                .padding(.horizontal, Spacing.medium)
                .padding(.top, Spacing.medium)
                .padding(.bottom, Spacing.small)

                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(
                                    tint: Colors.neutral600
                                )
                            )
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else if let error = viewModel.errorMessage {
                    VStack {
                        Spacer()
                        ContentUnavailableView {
                            Label(
                                String(localized: "common.error"),
                                systemImage: "exclamationmark.triangle"
                            )
                        } description: {
                            Text(error).multilineTextAlignment(.center)
                        } actions: {
                            Button(String(localized: "common.try_again")) {
                                Task { await viewModel.loadFavorites() }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else if viewModel.artworks.isEmpty {
                    VStack {
                        Spacer()
                        ContentUnavailableView {
                            Label(String(localized: "favorites.empty.title"), systemImage: "heart")
                        } description: {
                            Text(
                                String(localized: "favorites.empty.description")
                            )
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                } else {
                    List {
                        ForEach(viewModel.artworks) { artwork in
                            Button {
                                coordinator.navigateToArtworkDetail(
                                    artworkId: artwork.id
                                )
                            } label: {
                                HStack(spacing: Spacing.small) {
                                    LazyImage(imageID: artwork.imageID)
                                        .frame(width: 60, height: 60)
                                        .clipShape(
                                            RoundedRectangle(
                                                cornerRadius: Spacing.xSmall,
                                                style: .continuous
                                            )
                                        )

                                    VStack(alignment: .leading, spacing: Spacing.xsSmall) {
                                        Text(artwork.title)
                                            .font(.body)
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)

                                        Text(
                                            artwork.artistTitle ?? "Artist"
                                        )
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    }

                                    Spacer()

                                    Button {
                                        withAnimation {
                                            favoritesStore.toggleFavorite(artwork.id)
                                            viewModel.artworks.removeAll { $0.id == artwork.id }
                                        }
                                    } label: {
                                        Image(systemName: "heart.fill")
                                            .foregroundStyle(.red)
                                            .font(.system(size: 20))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    favoritesStore.toggleFavorite(artwork.id)
                                    viewModel.artworks.removeAll {
                                        $0.id == artwork.id
                                    }
                                }
                            }
                        }

                    }
                    .scrollContentBackground(.hidden)
                    .background(Colors.neutral50)
                }
            }
        }
        .navigationTitle(String(localized: "favorites.navigation.title"))
        .onAppear {
            Task {
                await viewModel.loadFavorites()
            }
        }
    }
}
