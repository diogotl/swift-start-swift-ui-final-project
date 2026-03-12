//
//  ArtistRepositoryProtocol.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

protocol ArtistRepositoryProtocol {
    func fetchArtist(id: Int) async throws -> Artist
    func fetchArtistArtworks(artistId: Int, page: Int, limit: Int) async throws -> (
        artworks: [Artwork], hasNextPage: Bool
    )
}
