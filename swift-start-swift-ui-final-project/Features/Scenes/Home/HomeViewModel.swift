//
//  HomeViewModel.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var items: [Artwork] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchByTitleQuery: String = ""

    private let service: HomeViewService

    init(service: HomeViewService) {
        self.service = service
    }

    func loadItems() async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await service.fetchItems()
        } catch {
            errorMessage = "Failed to load items"
        }

        isLoading = false
    }

    func searchItems() async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await service.fetchItems(searchQuery: searchByTitleQuery)
        } catch {
            errorMessage = "Failed to load items"
        }

        isLoading = false
    }
}
