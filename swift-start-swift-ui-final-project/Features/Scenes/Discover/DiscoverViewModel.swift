//
//  DiscoverViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Combine
import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {

    @Published var exhibitions: [Exhibition] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let exhibitionRepository: ExhibitionRepositoryProtocol

    init(exhibitionRepository: ExhibitionRepositoryProtocol) {
        self.exhibitionRepository = exhibitionRepository
    }

    func loadExhibitions() async {
        isLoading = true

        do {
            exhibitions = try await exhibitionRepository.fetchExhibitions(limit: 6)
        } catch {
            errorMessage = "\(error.localizedDescription)"
        }

        isLoading = false
    }
}
