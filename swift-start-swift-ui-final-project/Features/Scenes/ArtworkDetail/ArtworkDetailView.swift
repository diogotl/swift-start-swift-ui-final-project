//
//  ArtworkDetailView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct ArtworkDetailView: View {

    @StateObject private var viewModel: ArtworkDetailViewModel

    init(viewModel: ArtworkDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.n50
                .ignoresSafeArea()

            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                    } else if let artwork = viewModel.artwork {
                        ScrollView {
                            VStack {
                                Text(artwork.title)

                                if let artistTitle = artwork.artistTitle {
                                    Text(artistTitle)
                                }

                                if let dateDisplay = artwork.dateDisplay {
                                    Text(dateDisplay)
                                }

                                Divider()

                                VStack {
                                    if let dimensions = artwork.dimensions {
                                        DetailFieldItem(
                                            title: "Dimensions",
                                            value: dimensions
                                        )
                                    }

                                    if let mediumDisplay = artwork.mediumDisplay
                                    {
                                        DetailFieldItem(
                                            title: "Medium",
                                            value: mediumDisplay
                                        )
                                    }

                                    if let placeOfOrigin = artwork.placeOfOrigin
                                    {
                                        DetailFieldItem(
                                            title: "Place of Origin",
                                            value: placeOfOrigin
                                        )
                                    }

                                    if let description = artwork.description {
                                        DetailFieldItem(
                                            title: "Description",
                                            value: description
                                        )
                                    }

                                    if let provenanceText = artwork
                                        .provenanceText
                                    {
                                        DetailFieldItem(
                                            title: "Provenance",
                                            value: provenanceText
                                        )
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    } else {
                        Text("no data available")
                    }
                }
                .navigationTitle("details")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task {
            await viewModel.loadArtworkDetail()
        }
    }
}
