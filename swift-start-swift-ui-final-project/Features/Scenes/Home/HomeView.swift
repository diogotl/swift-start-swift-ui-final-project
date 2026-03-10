import Combine
//
//  HomeView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//
import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: Coordinator

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50
                .ignoresSafeArea()
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                } else {
                    VStack(spacing: 0) {

                        HStack {
                            Text(String(localized: "home.header.title"))
                                .font(Typography.headingMd)
                            Spacer()
                        }
                        .padding(.horizontal, Spacing.medium)
                        .padding(.top, Spacing.medium)
                        .padding(.bottom, Spacing.small)

                        HStack(spacing: Spacing.xSmall) {
                            ZStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(Colors.neutral400)

                                    TextField(
                                        String(localized: "home.search.placeholder"),
                                        text: $viewModel.searchByTitleQuery
                                    )
                                    .foregroundStyle(Colors.neutral950)

                                    if !viewModel.searchByTitleQuery.isEmpty {
                                        Button {
                                            viewModel.searchByTitleQuery = ""
                                        } label: {
                                            Image(
                                                systemName: "xmark.circle.fill"
                                            )
                                            .foregroundStyle(Colors.neutral400)
                                        }
                                    }
                                }
                                .padding(.horizontal, Spacing.small)
                                .padding(.vertical, 10)
                                .background(Colors.neutral100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Colors.neutral300, lineWidth: 1)
                                )
                                .cornerRadius(10)
                                .frame(height: 44)
                            }

                            Button(String(localized: "home.search.button")) {
                                Task {
                                    await viewModel.searchItems()
                                }
                            }
                            .foregroundStyle(Colors.neutral100)
                            .padding(.horizontal, Spacing.medium)
                            .padding(.vertical, Spacing.small)
                            .background(Colors.neutral900)
                            .cornerRadius(10)
                            .frame(height: 44)
                            .disabled(viewModel.searchByTitleQuery.isEmpty)
                        }
                        .padding(.horizontal, Spacing.medium)
                        .padding(.bottom, Spacing.small)

                        ZStack {
                            ScrollView {
                                LazyVStack(spacing: Spacing.medium) {
                                    ForEach(viewModel.items) { item in
                                        Button {
                                            coordinator.navigateToArtworkDetail(
                                                artworkId: item.id
                                            )
                                        } label: {
                                            ArtworkCardView(artwork: item)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .onAppear {
                                            guard
                                                item.id
                                                    == viewModel.items.last?.id
                                            else { return }
                                            Task {
                                                await viewModel.loadMoreItems()
                                            }
                                        }
                                    }

                                    if viewModel.isLoadingMore {
                                        HStack {
                                            Spacer()
                                            ProgressView()
                                                .progressViewStyle(
                                                    CircularProgressViewStyle(
                                                        tint: Colors.neutral600
                                                    )
                                                )
                                                .padding(
                                                    .vertical,
                                                    Spacing.medium
                                                )
                                            Spacer()
                                        }
                                    }
                                }
                                .padding(.horizontal, Spacing.medium)
                            }
                            .opacity(viewModel.isLoadingList ? 0.3 : 1.0)

                            if viewModel.isLoadingList {
                                ProgressView()
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.loadItems()
            }
        }
    }
}
