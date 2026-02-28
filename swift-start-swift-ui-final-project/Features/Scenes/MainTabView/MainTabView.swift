//
//  MainTabView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 28/02/2026.
//

import SwiftUI

struct MainTabView: View {
    let homeViewModel: HomeViewModel

    //needs reworking
    init() {
        let baseUrl = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
        print(baseUrl)
        let apiClient = APIClient(baseURL: baseUrl)
        let homeViewService = HomeViewService(apiClient: apiClient)
        self.homeViewModel = HomeViewModel(service: homeViewService)
    }

    var body: some View {
        HStack {
            TabView {
                HomeView(viewModel: homeViewModel)
                    .tabItem {
                        Label("", systemImage: "house.fill")
                    }
                HomeView(viewModel: homeViewModel)
                    .tabItem {
                        Label("", systemImage: "house.fill")
                    }
            }
            .accentColor(Colors.emerald100)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {

                }
            }
        }
    }
}
