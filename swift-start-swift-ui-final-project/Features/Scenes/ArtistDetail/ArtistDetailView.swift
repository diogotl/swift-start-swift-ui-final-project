//
//  ArtistDetailView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct ArtistDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ArtistDetailViewModel
    @EnvironmentObject private var coordinator: Coordinator

    @State var isBioOpen: Bool = false

    init(viewModel: ArtistDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50.ignoresSafeArea()
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Colors.neutral600)
                        )
                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label(
                            String(localized: "artist.detail.unable_to_load"),
                            systemImage: "exclamationmark.triangle"
                        )
                    } description: {
                        Text(error)
                            .multilineTextAlignment(.center)
                    } actions: {
                        Button(String(localized: "common.try_again")) {
                            Task { await viewModel.load() }
                        }
                        .buttonStyle(.borderedProminent)
                    }

                } else if let artist = viewModel.artist {
                    ScrollView {
                        VStack(alignment: .leading, spacing: Spacing.large) {
                            VStack(alignment: .leading, spacing: Spacing.small)
                            {
                                Text(artist.name)
                                    .font(Typography.headingLg)
                                    .foregroundStyle(Colors.neutral900)
                                    .lineLimit(3)

                                if let sortName = artist.sortName,
                                    sortName != artist.name
                                {
                                    Text(sortName)
                                        .font(Typography.bodySm)
                                        .foregroundStyle(Colors.neutral600)
                                }

                                if let lifespan = artist.formatLifespan(
                                    birthYear: artist.birthYear,
                                    deathYear: artist.deathYear
                                ) {
                                    HStack(spacing: Spacing.xSmall) {
                                        Text(lifespan)
                                            .font(Typography.bodySm)
                                            .foregroundStyle(Colors.neutral600)
                                    }
                                }

                                if artist.isArtist {
                                    HStack(spacing: Spacing.xSmall) {
                                        Text(
                                            String(
                                                localized:
                                                    "artist.detail.artist_badge"
                                            )
                                        )
                                        .font(Typography.bodyXs)
                                    }
                                    .foregroundStyle(Colors.brown500)
                                    .padding(.horizontal, Spacing.small)
                                    .padding(.vertical, Spacing.xsSmall)
                                    .background(Colors.neutral50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(
                                                Colors.brown200,
                                                lineWidth: 1
                                            )
                                    )
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )
                                }
                            }
                            .padding(.horizontal, Spacing.medium)

                            Divider()
                                .background(Colors.neutral200)
                                .padding(.horizontal, Spacing.medium)

                            VStack(alignment: .leading, spacing: Spacing.medium)
                            {
                                HStack(spacing: Spacing.xSmall) {

                                    Text(
                                        String(
                                            localized: "artist.detail.biography"
                                        )
                                    )
                                    .font(Typography.headingMd)
                                    .foregroundStyle(Colors.neutral900)
                                }

                                if let bio = artist.bio, !bio.isEmpty {
                                    let bioText = bio.stripHTML()

                                    VStack(
                                        alignment: .leading,
                                        spacing: Spacing.xSmall
                                    ) {
                                        Text(bioText)
                                            .font(Typography.bodySm)
                                            .foregroundStyle(Colors.neutral700)
                                            .lineSpacing(6)
                                            .lineLimit(isBioOpen ? nil : 5)

                                        HStack {
                                            Spacer()
                                            Button {
                                                withAnimation(
                                                    .easeInOut(duration: 0.22)
                                                ) {
                                                    isBioOpen.toggle()
                                                }
                                            } label: {
                                                HStack(spacing: Spacing.xsSmall)
                                                {
                                                    Text(
                                                        isBioOpen
                                                            ? String(
                                                                localized:
                                                                    "common.close"
                                                            )
                                                            : String(
                                                                localized:
                                                                    "common.read_more"
                                                            )
                                                    )
                                                    .font(Typography.headingXs)
                                                    .foregroundStyle(
                                                        Colors.emerald500
                                                    )
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }

                                } else {
                                    Text(
                                        String(
                                            localized:
                                                "artist.detail.no_biography"
                                        )
                                    )
                                }
                            }
                            .padding(.horizontal, Spacing.medium)

                            Divider()
                                .background(Colors.neutral200)
                                .padding(.horizontal, Spacing.medium)

                            VStack(alignment: .leading, spacing: Spacing.medium)
                            {
                                Text(
                                    String(
                                        localized:
                                            "artist.detail.artworks_by \(artist.name)"
                                    )
                                )
                                .font(Typography.headingMd)
                                .foregroundStyle(Colors.neutral900)
                                .padding(.horizontal, Spacing.medium)

                                if viewModel.isLoadingArtworks {
                                    HStack {
                                        Spacer()
                                        ProgressView()
                                            .progressViewStyle(
                                                CircularProgressViewStyle(
                                                    tint: Colors.neutral600
                                                )
                                            )
                                            .padding(.vertical, Spacing.large)
                                        Spacer()
                                    }
                                } else {
                                    VStack(spacing: Spacing.medium) {
                                        LazyVStack(spacing: Spacing.medium) {
                                            ForEach(viewModel.artworks) {
                                                artwork in
                                                Button {
                                                    coordinator
                                                        .navigateToArtworkDetail(
                                                            artworkId: artwork
                                                                .id
                                                        )
                                                } label: {
                                                    ArtworkCardView(
                                                        artwork: artwork
                                                    )
                                                }
                                                .buttonStyle(PlainButtonStyle())
                                            }
                                        }
                                        .padding(.horizontal, Spacing.medium)

                                        HStack(spacing: Spacing.xSmall) {
                                            Button {
                                                Task {
                                                    await viewModel
                                                        .loadPreviousPage()
                                                }
                                            } label: {
                                                HStack(spacing: Spacing.xsSmall)
                                                {
                                                    Image(
                                                        systemName:
                                                            "chevron.left"
                                                    )
                                                    Text(
                                                        String(
                                                            localized:
                                                                "common.previous"
                                                        )
                                                    )
                                                    .font(Typography.button)
                                                }
                                                .foregroundStyle(
                                                    viewModel.currentPage > 1
                                                        ? Colors.neutral900
                                                        : Colors.neutral400
                                                )
                                                .padding(
                                                    .horizontal,
                                                    Spacing.medium
                                                )
                                                .padding(
                                                    .vertical,
                                                    Spacing.xSmall
                                                )
                                                .background(Colors.neutral50)
                                                .clipShape(
                                                    RoundedRectangle(
                                                        cornerRadius: 8
                                                    )
                                                )
                                                .overlay(
                                                    RoundedRectangle(
                                                        cornerRadius: 8
                                                    )
                                                    .stroke(
                                                        Colors.neutral200,
                                                        lineWidth: 1
                                                    )
                                                )
                                            }
                                            .disabled(
                                                viewModel.currentPage <= 1
                                                    || viewModel
                                                        .isLoadingArtworks
                                            )
                                            .opacity(
                                                viewModel.currentPage <= 1
                                                    ? 0.5 : 1
                                            )

                                            Button {
                                                Task {
                                                    await viewModel.loadNextPage()
                                                }
                                            } label: {
                                                HStack(spacing: Spacing.xsSmall)
                                                {
                                                    Text(
                                                        String(
                                                            localized:
                                                                "common.next"
                                                        )
                                                    )
                                                    .font(Typography.button)
                                                    Image(
                                                        systemName:
                                                            "chevron.right"
                                                    )
                                                }
                                                .foregroundStyle(
                                                    viewModel.hasNextPage
                                                        ? Colors.neutral900
                                                        : Colors.neutral400
                                                )
                                                .padding(
                                                    .horizontal,
                                                    Spacing.medium
                                                )
                                                .padding(
                                                    .vertical,
                                                    Spacing.xSmall
                                                )
                                                .background(Colors.neutral50)
                                                .clipShape(
                                                    RoundedRectangle(
                                                        cornerRadius: 8
                                                    )
                                                )
                                                .overlay(
                                                    RoundedRectangle(
                                                        cornerRadius: 8
                                                    )
                                                    .stroke(
                                                        Colors.neutral200,
                                                        lineWidth: 1
                                                    )
                                                )
                                            }
                                            .disabled(
                                                !viewModel.hasNextPage
                                                    || viewModel
                                                        .isLoadingArtworks
                                            )
                                            .opacity(
                                                !viewModel.hasNextPage ? 0.5 : 1
                                            )
                                        }
                                        .padding(.horizontal, Spacing.medium)
                                        .padding(.vertical, Spacing.small)
                                    }
                                }
                            }

                        }
                        .padding(.top, Spacing.small)
                    }

                } else {
                    Text(String(localized: "common.error"))
                }
            }
        }
        .navigationTitle(
            (viewModel.artist?.name ?? viewModel.artist?.sortName) ?? ""
        )
        .task {
            await viewModel.load()
        }
    }

}
