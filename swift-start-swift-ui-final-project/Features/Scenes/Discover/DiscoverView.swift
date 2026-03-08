//
//  DiscoverView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject private var viewModel: DiscoverViewModel
    @EnvironmentObject private var coordinator: Coordinator

    init(viewModel: DiscoverViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: Spacing.medium) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Discover Exhibitions")
                            .font(Typography.headingMd)
                        Text(
                            "Explore current and past exhibitions from the Art Institute of Chicago"
                        )
                        .font(Typography.bodySm)
                        .foregroundStyle(Colors.neutral500)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 12)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Colors.neutral600)
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
                            Task { await viewModel.loadExhibitions() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                } else if viewModel.exhibitions.isEmpty {
                    Spacer()
                    ContentUnavailableView {
                        Label("No Exhibitions", systemImage: "building.columns")
                    } description: {
                        Text("No exhibitions")
                    }
                    Spacer()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Spacing.medium) {
                            ForEach(viewModel.exhibitions) { exhibition in
                                ExhibitionCard(exhibition: exhibition)
                            }
                        }
                        .padding(.horizontal, Spacing.medium)
                    }
                }
                Spacer()
            }
        }
        .task {
            await viewModel.loadExhibitions()
        }
    }
}
