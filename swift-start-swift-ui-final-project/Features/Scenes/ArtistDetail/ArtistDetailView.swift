//
//  ArtistDetailView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct ArtistDetailView: View {
    @StateObject private var viewModel: ArtistDetailViewModel

    init(viewModel: ArtistDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("loadind")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("erro")
                            .font(.headline)
                        Text(error)
                            .font(.subheadline)
                        Button("try again") {
                            Task {
                                await viewModel.load()
                            }
                        }
                    }.padding()
                } else if let artist = viewModel.artist {
                    List {
                        Section {
                            Text(artist.name).font(.title2).bold()
                            if !artist.bio.isEmpty {
                                Text(artist.bio).foregroundStyle(.secondary)
                            }
                        }
                    }
                } else {
                    Text("0 artists")
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}
