//
//  ArtworkDetailViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import Combine
import SwiftUI

@MainActor
final class ArtworkDetailViewModel: ObservableObject {

    @Published var artwork: Artwork?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let artworkRepository: ArtworkRepositoryProtocol
    private let artworkId: Int

    init(artworkRepository: ArtworkRepositoryProtocol, artworkId: Int) {
        self.artworkRepository = artworkRepository
        self.artworkId = artworkId
    }

    func loadArtworkDetail() async {
        isLoading = true
        errorMessage = nil

        do {
            artwork = try await artworkRepository.fetchArtwork(id: artworkId)
        } catch {
            errorMessage = "Failed to load artwork details"
        }

        isLoading = false
    }
}
