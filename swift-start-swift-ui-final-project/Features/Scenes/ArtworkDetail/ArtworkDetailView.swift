//
//  ArtworkDetailView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct ArtworkDetailView: View {

    // @Environment(\.dismiss) private var dismiss
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
                            String(localized: "common.error"),
                            systemImage: "exclamationmark.triangle"
                        )
                    } description: {
                        Text(
                            String(localized: "common.error.description")
                        )
                    } actions: {
                        // TODO: try again
                    }
                }

                else if let artwork = viewModel.artwork {

                    ScrollView {
                        VStack(alignment: .leading, spacing: Spacing.large) {

                            if let imageID = artwork.imageID {
                                LazyImage(imageID: imageID)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .frame(maxHeight: 400)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 16)
                                    )
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

                                            Text(String(localized: "artwork.detail.no_image"))
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
                                    .frame(maxWidth: .infinity, alignment: .leading)

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
                                            title: String(localized: "artwork.detail.dimensions"),
                                            value: dimensions
                                        )
                                    }
                                    if let mediumDisplay = artwork.mediumDisplay {
                                        DetailFieldItem(
                                            title: String(localized: "artwork.detail.medium"),
                                            value: mediumDisplay
                                        )
                                    }

                                    if let origin = artwork.placeOfOrigin {
                                        DetailFieldItem(
                                            title: String(localized: "artwork.detail.origin"),
                                            value: origin
                                        )
                                    }

                                    if let style = artwork.styleTitle {
                                        DetailFieldItem(
                                            title: String(localized: "artwork.detail.style"),
                                            value: style
                                        )
                                    }

                                    if let classification = artwork
                                        .classificationTitle
                                    {
                                        DetailFieldItem(
                                            title: String(
                                                localized: "artwork.detail.classification"),
                                            value: classification
                                        )
                                    }

                                    if let description = artwork.description {
                                        DetailFieldItem(
                                            title: String(localized: "artwork.detail.description"),
                                            value: description.stripHTML()
                                        )
                                    }

                                    if let provenance = artwork.provenanceText {
                                        DetailFieldItem(
                                            title: String(localized: "artwork.detail.provenance"),
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
                    Text(String(localized: "artwork.detail.no_data"))
                        .foregroundStyle(Colors.neutral500)
                }
            }
        }
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
                            Label(
                                String(localized: "artwork.detail.view_artist"),
                                systemImage: "person")
                        }
                    }

                    if let id = viewModel.artwork?.id {
                        Link(
                            destination: URL(
                                string: "https://www.artic.edu/artworks/\(id)"
                            )!
                        ) {
                            Label(
                                String(localized: "artwork.detail.visit_museum"),
                                systemImage: "arrow.up.right.square"
                            )
                        }
                    }

                    Button {
                        // TODO: tentar deep-linking
                    } label: {
                        Label(String(localized: "common.share"), systemImage: "square.and.arrow.up")
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
