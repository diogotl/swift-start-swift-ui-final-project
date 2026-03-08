//
//  DiscoverViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import SwiftUI

@MainActor
final class DiscoverViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func makeDiscoverView() -> DiscoverView {
        let exhibitionRepository = ExhibitionRepository(apiClient: apiClient)
        let viewModel = DiscoverViewModel(
            exhibitionRepository: exhibitionRepository
        )
        return DiscoverView(viewModel: viewModel)
    }
}
