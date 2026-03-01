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
                        VStack {
                            HStack {
                                TextField(
                                    "Search by artworks...",
                                    text: $viewModel.searchByTitleQuery
                                )

                                Button("Search") {
                                    Task {
                                        await viewModel.searchItems()
                                    }
                                }
//                                .disabled(viewModel.searchByTitleQuery.isEmpty)
                            }

                            List(viewModel.items) { item in
                                NavigationLink(destination: createDetailView(for: item.id)) {
                                    Text(item.title)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Items")
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
        let viewModel = ArtworkDetailViewModel(service: service, artworkId: artworkId)
        return ArtworkDetailView(viewModel: viewModel)
    }
}
