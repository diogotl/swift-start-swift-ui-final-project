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

    init(viewModel: ArtworkDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50.ignoresSafeArea()

            Group {
                if viewModel.isLoading {
                    ProgressView()
                }

                else if let error = viewModel.errorMessage {
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

                            VStack(alignment: .leading, spacing: Spacing.medium) {

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

                                HStack(spacing: Spacing.xSmall) {

                                    if let type = artwork.artworkTypeTitle {
                                        Text(type)
                                            .font(Typography.bodyXs)
                                            .foregroundStyle(Colors.neutral700)
                                            .padding(.horizontal, Spacing.small)
                                            .padding(.vertical, 6)
                                            .background(Colors.neutral100)
                                            .overlay(
                                                RoundedRectangle(
                                                    cornerRadius: 12
                                                )
                                                .stroke(
                                                    Colors.neutral300,
                                                    lineWidth: 1
                                                )
                                            )
                                            .clipShape(
                                                RoundedRectangle(
                                                    cornerRadius: 12
                                                )
                                            )
                                    }

                                    if let department = artwork.departmentTitle {
                                        Text(department)
                                            .font(Typography.bodyXs)
                                            .foregroundStyle(Colors.neutral600)
                                            .padding(.horizontal, Spacing.small)
                                            .padding(.vertical, 6)
                                            .overlay(
                                                RoundedRectangle(
                                                    cornerRadius: 12
                                                )
                                                .stroke(
                                                    Colors.neutral300,
                                                    lineWidth: 1
                                                )
                                            )
                                            .clipShape(
                                                RoundedRectangle(
                                                    cornerRadius: 12
                                                )
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Colors.neutral950)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(Colors.neutral900)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Menu {

                    if let artistId = viewModel.artwork?.artistIDs?.first {
                        NavigationLink {
                            createArtistDetailView(for: artistId)
                        } label: {
                            Label("View Artist", systemImage: "person")
                        }
                    }

                    Button {
                        // TODO: share
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

    // TODO: refactor
    private func createArtistDetailView(for artistId: Int) -> ArtistDetailView {
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        let apiClient = APIClient(baseURL: baseUrl)
        let service = ArtistDetailViewService(apiClient: apiClient)
        let vm = ArtistDetailViewModel(service: service, artistId: artistId)
        return ArtistDetailView(viewModel: vm)
    }
}
