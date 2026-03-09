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
                        Text("Your personal favorites")
                            .font(Typography.headingMd)
                        Text(
                            "\(favoritesStore.count) favourite artworks"
                        )
                        .font(Typography.bodySm)
                        .foregroundStyle(Colors.neutral500)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 12)

                ZStack {
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(
                                    tint: Colors.neutral600
                                )
                            )
                        Spacer()

                    } else if let error = viewModel.errorMessage {
                        Spacer()
                        ContentUnavailableView {
                            Label(
                                "Error",
                                systemImage: "exclamationmark.triangle"
                            )
                        } description: {
                            Text(error).multilineTextAlignment(.center)
                        } actions: {
                            Button("Try Again") {
                                Task { await viewModel.loadFavorites() }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        Spacer()

                    } else if viewModel.artworks.isEmpty {
                        Spacer()
                        ContentUnavailableView {
                            Label("No favorites yet", systemImage: "heart")
                        } description: {
                            Text(
                                "Start exploring the collection and save artworks you love by tapping the heart icon on any artwork."
                            )
                        }
                        Spacer()

                    } else {
                        ScrollView {
                            LazyVStack(spacing: Spacing.medium) {
                                ForEach(viewModel.artworks) { artwork in
                                    Button {
                                        coordinator.navigateToArtworkDetail(
                                            artworkId: artwork.id
                                        )
                                    } label: {
                                        HStack(spacing: Spacing.small) {
                                            LazyImage(imageID: artwork.imageID)
                                                .frame(width: 80, height: 80)
                                                .clipShape(
                                                    RoundedRectangle(
                                                        cornerRadius: Spacing
                                                            .medium,
                                                        style: .continuous
                                                    )
                                                )

                                            VStack(
                                                alignment: .leading,
                                                spacing: Spacing.xsSmall
                                            ) {
                                                Text(artwork.title)
                                                    .font(Typography.bodyMd)
                                                    .foregroundStyle(
                                                        Colors.neutral900
                                                    )
                                                    .lineLimit(1)

                                                Text(
                                                    artwork.artistTitle
                                                        ?? "Artist"
                                                )
                                                .font(Typography.bodySm)
                                                .foregroundStyle(
                                                    Colors.neutral500
                                                )
                                                .lineLimit(1)
                                            }

                                            Spacer()

                                            Image(systemName: "chevron.right")
                                                .font(
                                                    .system(
                                                        size: 12,
                                                        weight: .semibold
                                                    )
                                                )
                                                .foregroundStyle(
                                                    Colors.neutral400
                                                )
                                        }
                                        .padding(Spacing.medium)
                                        .background(Colors.neutral50)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, Spacing.medium)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            Task {
                await viewModel.loadFavorites()
            }
        }
    }
}
