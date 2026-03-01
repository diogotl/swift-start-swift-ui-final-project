//
//  ArtworkDetailViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI
import Combine

@MainActor
final class ArtworkDetailViewModel: ObservableObject {

    @Published var artwork: Artwork?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: ArtworkDetailService
    private let artworkId: Int

    init(service: ArtworkDetailService, artworkId: Int) {
        self.service = service
        self.artworkId = artworkId
    }

    func loadArtworkDetail() async {
        isLoading = true
        errorMessage = nil

        do {
            artwork = try await service.fetchArtworkDetail(id: artworkId)
        } catch {
            errorMessage = "Failed to load artwork details"
        }

        isLoading = false
    }
}
