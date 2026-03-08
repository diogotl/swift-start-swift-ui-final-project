//
//  ExhibitionRepositoryProtocol.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

protocol ExhibitionRepositoryProtocol {
    func fetchExhibitions(limit: Int) async throws -> [Exhibition]
    func fetchExhibition(id: Int) async throws -> Exhibition
}
