//
//  Route.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 03/03/2026.
//

import Foundation

enum Route: Hashable {
    case home
    case favorites
    case artworkDetail(artworkId: Int)
    case artistDetail(artistId: Int)
}
