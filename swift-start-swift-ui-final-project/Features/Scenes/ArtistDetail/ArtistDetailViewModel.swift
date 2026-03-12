//
//  ArtistDetailViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class ArtistDetailViewModel: ObservableObject {

    @Published var artist: Artist?
    @Published var artworks: [Artwork] = []
    @Published var isLoading = false
    @Published var isLoadingArtworks = false
    @Published var errorMessage: String?
    @Published var currentPage = 1
    @Published var hasNextPage = false

    private let artistRepository: ArtistRepositoryProtocol
    private let artistId: Int
    private let artworksPerPage = 12

    init(artistRepository: ArtistRepositoryProtocol, artistId: Int) {
        self.artistRepository = artistRepository
        self.artistId = artistId
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            artist = try await artistRepository.fetchArtist(id: artistId)
            await loadArtworks()
        } catch {
            errorMessage = "Failed to load artist information"
        }

        isLoading = false
    }

    func loadArtworks() async {
        isLoadingArtworks = true

        do {
            let result = try await artistRepository.fetchArtistArtworks(
                artistId: artistId,
                page: currentPage,
                limit: artworksPerPage
            )
            artworks = result.artworks
            hasNextPage = result.hasNextPage
        } catch {
            artworks = []
            hasNextPage = false
        }

        isLoadingArtworks = false
    }

    func loadNextPage() async {
        currentPage += 1
        await loadArtworks()
    }

    func loadPreviousPage() async {
        guard currentPage > 1 else { return }
        currentPage -= 1
        await loadArtworks()
    }
}
