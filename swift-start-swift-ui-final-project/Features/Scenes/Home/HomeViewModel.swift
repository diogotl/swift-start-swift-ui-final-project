//
//  HomeViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var items: [Artwork] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service: HomeViewService

    init(service: HomeViewService) {
        self.service = service
    }

    func loadItems() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await service.fetchItems()
            items = response.data
        } catch {
            errorMessage = "Failed to load items"
        }

        isLoading = false
    }
}
