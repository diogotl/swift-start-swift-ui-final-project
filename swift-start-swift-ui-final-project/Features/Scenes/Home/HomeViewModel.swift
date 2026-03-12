//
//  HomeViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var items: [Artwork] = []
    @Published var isLoading = false
    @Published var isLoadingList = false
    @Published var isLoadingMore = false
    @Published var errorMessage: String?
    @Published var searchByTitleQuery: String = ""
    @Published var currentPage = 1
    @Published var hasNextPage = true

    private let artworkRepository: ArtworkRepositoryProtocol
    private let itemsPerPage = 12

    init(artworkRepository: ArtworkRepositoryProtocol) {
        self.artworkRepository = artworkRepository
    }

    func loadItems() async {
        isLoading = true
        errorMessage = nil
        currentPage = 1

        do {
            let result = try await artworkRepository.fetchArtworks(
                page: currentPage,
                limit: itemsPerPage,
                query: nil
            )
            items = result.artworks
            hasNextPage = result.hasNextPage
        } catch {
            errorMessage = "Failed to load items"
        }

        isLoading = false
    }

    func searchItems() async {
        isLoadingList = true
        errorMessage = nil
        currentPage = 1

        do {
            let result = try await artworkRepository.fetchArtworks(
                page: currentPage,
                limit: itemsPerPage,
                query: searchByTitleQuery
            )
            items = result.artworks
            hasNextPage = result.hasNextPage
        } catch {
            errorMessage = "Failed to load items"
        }

        isLoadingList = false
    }

    func loadMoreItems() async {
        guard !isLoadingMore, hasNextPage else {
            return
        }

        isLoadingMore = true
        currentPage += 1

        do {
            let result = try await artworkRepository.fetchArtworks(
                page: currentPage,
                limit: itemsPerPage,
                query: searchByTitleQuery
            )
            items.append(contentsOf: result.artworks)
            hasNextPage = result.hasNextPage
        } catch {
            currentPage -= 1
        }

        isLoadingMore = false
    }
}
