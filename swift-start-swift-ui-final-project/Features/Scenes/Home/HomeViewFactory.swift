//
//  HomeViewFactory.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import SwiftUI

@MainActor
final class HomeViewFactory {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func makeHomeView() -> HomeView {
        let service = HomeViewService(apiClient: apiClient)
        let viewModel = HomeViewModel(service: service)
        return HomeView(viewModel: viewModel)
    }
}
