//
//  HomeView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//
import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Colors.n950
                .ignoresSafeArea()
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                    } else {
                        List(viewModel.items) { item in
                            NavigationLink(item.title) {
                                //ItemDetailView(item: item)
                            }
                            Text(item.title)
                        }
                    }
                }
                .navigationTitle("Items")
            }
            .task {
                await viewModel.loadItems()
            }
        }

    }
}
