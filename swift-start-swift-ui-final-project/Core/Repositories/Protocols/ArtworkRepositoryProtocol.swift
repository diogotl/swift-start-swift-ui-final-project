//
//  ArtworkRepositoryProtocol.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

protocol ArtworkRepositoryProtocol {
    func fetchArtworks(page: Int, limit: Int, query: String?) async throws -> [Artwork]
    func fetchArtwork(id: Int) async throws -> Artwork
    func fetchArtworksByIds(_ ids: [Int]) async throws -> [Artwork]
}
