//
//  FavoriteView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

// TODO: favourites page

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No favorites yet", systemImage: "heart")
        } description: {
            Text(
                
                "Start exploring the collection and save artworks you love by tapping the heart icon on any artwork."
            )
        } actions: {
            NavigationLink("Explore the collection") {
                //HomeView()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
