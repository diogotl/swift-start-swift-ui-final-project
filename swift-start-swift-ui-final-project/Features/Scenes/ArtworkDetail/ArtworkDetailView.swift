//
//  ArtworkDetailView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct ArtworkDetailView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ArtworkDetailViewModel
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var favoritesStore: FavoritesStore

    init(viewModel: ArtworkDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50.ignoresSafeArea()

            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label(
                            "Try Again",
                            systemImage: "exclamationmark.triangle"
                        )
                    } description: {
                        Text(
                            "erro...."
                        )
                    } actions: {
                        // TODO: try again
                    }
                }

                else if let artwork = viewModel.artwork {

                    ScrollView {
                        VStack(alignment: .leading, spacing: Spacing.large) {

                            if let imageID = artwork.imageID {
                                ZStack {
                                    LazyImage(imageID: imageID)
                                        .frame(height: 400)
                                        .clipped()
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 16)
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 400)
                                .padding(.horizontal, Spacing.medium)

                            } else {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Colors.neutral200,
                                                Colors.neutral300,
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .overlay(
                                        VStack(spacing: Spacing.small) {
                                            Image(systemName: "photo")
                                                .font(.system(size: 48))
                                                .foregroundStyle(
                                                    Colors.neutral400
                                                )

                                            Text("no image")
                                                .font(Typography.bodySm)
                                                .foregroundStyle(
                                                    Colors.neutral500
                                                )
                                        }
                                    )
                                    .frame(height: 400)
                                    .padding(.horizontal, Spacing.medium)
                            }

                            VStack(alignment: .leading, spacing: Spacing.xsSmall) {

                                Text(artwork.title)
                                    .font(Typography.headingLg)
                                    .foregroundStyle(Colors.neutral900)
                                    .multilineTextAlignment(.leading)

                                if let artistTitle = artwork.artistTitle {
                                    Text(artistTitle)
                                        .font(Typography.bodyLg)
                                        .foregroundStyle(Colors.brown500)
                                }

                                if let dateDisplay = artwork.dateDisplay {
                                    Text(dateDisplay)
                                        .font(Typography.bodySm)
                                        .foregroundStyle(Colors.neutral600)
                                }
                                Spacer()

                                HStack(spacing: Spacing.xSmall) {

                                    if let type = artwork.artworkTypeTitle {
                                        Badge(
                                            text: type,
                                            variant: .primary
                                        )
                                    }

                                    if let department = artwork.departmentTitle {
                                        Badge(
                                            text: department,
                                            variant: .secondary
                                        )
                                    }
                                }

                                Divider()
                                    .background(Colors.neutral200)
                                    .padding(.vertical, Spacing.xSmall)

                                VStack(
                                    alignment: .leading,
                                    spacing: Spacing.medium
                                ) {

                                    if let dimensions = artwork.dimensions {
                                        DetailFieldItem(
                                            title: "Dimensions",
                                            value: dimensions
                                        )
                                    }
                                    if let mediumDisplay = artwork.mediumDisplay {
                                        DetailFieldItem(
                                            title: "Medium",
                                            value: mediumDisplay
                                        )
                                    }

                                    if let origin = artwork.placeOfOrigin {
                                        DetailFieldItem(
                                            title: "Origin",
                                            value: origin
                                        )
                                    }

                                    if let style = artwork.styleTitle {
                                        DetailFieldItem(
                                            title: "Style",
                                            value: style
                                        )
                                    }

                                    if let classification = artwork
                                        .classificationTitle
                                    {
                                        DetailFieldItem(
                                            title: "Classification",
                                            value: classification
                                        )
                                    }

                                    if let description = artwork.description {
                                        DetailFieldItem(
                                            title: "Description",
                                            value: description.stripHTML()
                                        )
                                    }

                                    if let provenance = artwork.provenanceText {
                                        DetailFieldItem(
                                            title: "Provenance",
                                            value: provenance.stripHTML()
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal, Spacing.medium)
                            .padding(.bottom, Spacing.large)

                        }
                        .padding(.top, Spacing.small)
                    }
                }

                else {
                    Text("no data")
                        .foregroundStyle(Colors.neutral500)
                }
            }
        }
        .navigationTitle(viewModel.artwork?.title ?? "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if let artworkId = viewModel.artwork?.id {
                        favoritesStore.toggleFavorite(artworkId)
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(isFavorite ? .red : Colors.neutral900)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {

                    if let artistId = viewModel.artwork?.artistIDs?.first {
                        Button {
                            coordinator.navigateToArtistDetail(
                                artistId: artistId
                            )
                        } label: {
                            Label("View Artist", systemImage: "person")
                        }
                    }

                    if let id = viewModel.artwork?.id {
                        Link(
                            destination: URL(
                                string: "https://www.artic.edu/artworks/\(id)"
                            )!
                        ) {
                            Label(
                                "Visit Museum Page",
                                systemImage: "arrow.up.right.square"
                            )
                        }
                    }

                    Button {
                        // TODO: tentar deep-linking
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }

                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Colors.neutral900)
                }
            }
        }
        .task {
            await viewModel.loadArtworkDetail()
        }
    }

    private var isFavorite: Bool {
        guard let artworkId = viewModel.artwork?.id else { return false }
        return favoritesStore.favorites.contains(artworkId)
    }
}
