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

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.neutral50
                .ignoresSafeArea()
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                    } else {
                        VStack(spacing: 0) {

                            HStack {
                                Text("Explore the collection")
                                    .font(Typography.headingMd)
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.bottom, 12)

                            HStack(spacing: 8) {
                                ZStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundStyle(Colors.neutral400)

                                        TextField(
                                            "Search by artworks...",
                                            text: $viewModel.searchByTitleQuery
                                        )
                                        .foregroundStyle(Colors.neutral950)

                                        if !viewModel.searchByTitleQuery.isEmpty {
                                            Button {
                                                viewModel.searchByTitleQuery = ""
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(Colors.neutral400)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(Colors.neutral100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Colors.neutral300, lineWidth: 1)
                                    )
                                    .cornerRadius(10)
                                    .frame(height: 44)
                                }

                                Button("Search") {
                                    Task {
                                        await viewModel.searchItems()
                                    }
                                }
                                .foregroundStyle(Colors.neutral100)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Colors.neutral900)
                                .cornerRadius(10)
                                .frame(height: 44)
                                .disabled(viewModel.searchByTitleQuery.isEmpty)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 12)

                            ZStack {
                                ScrollView {
                                    LazyVStack(spacing: Spacing.medium) {
                                        ForEach(viewModel.items) { item in
                                            NavigationLink(
                                                destination: createDetailView(for: item.id)
                                            ) {
                                                ArtworkCardView(artwork: item)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .opacity(viewModel.isLoadingList ? 0.3 : 1.0)

                                if viewModel.isLoadingList {
                                    ProgressView()
                                }
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

    //TODO transform this method into a factory
    private func createDetailView(for artworkId: Int) -> ArtworkDetailView {
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        let apiClient = APIClient(baseURL: baseUrl)
        let service = ArtworkDetailService(apiClient: apiClient)
        let viewModel = ArtworkDetailViewModel(
            service: service,
            artworkId: artworkId
        )
        return ArtworkDetailView(viewModel: viewModel)
    }
}
