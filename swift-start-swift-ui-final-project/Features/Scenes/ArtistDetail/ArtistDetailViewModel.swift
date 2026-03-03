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
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: ArtistDetailViewService
    private let artistId: Int

    init(service: ArtistDetailViewService, artistId: Int) {
        self.service = service
        self.artistId = artistId
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            artist = try await service.fetchArtist(id: artistId)
        } catch {
            errorMessage = "erro"
        }

        isLoading = false
    }
}
