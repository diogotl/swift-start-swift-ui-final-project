//
//  Artwork.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//

import Foundation

struct Artwork: Decodable, Identifiable {
    let id: Int
    let title: String
    let artistTitle: String?
    let dateDisplay: String?
    let imageID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artistTitle = "artist_title"
        case dateDisplay = "date_display"
        case imageID = "image_id"
    }
}

struct ArtworkResponse: Decodable {
    let data: [Artwork]
}
