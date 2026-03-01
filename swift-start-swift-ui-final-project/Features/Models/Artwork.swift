//
//  Artwork.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 27/02/2026.
//

import Foundation

struct Artwork: Identifiable {
    let id: Int
    let title: String
    let artistTitle: String?
    let dateDisplay: String?
    let imageID: String?

    // artwork detail
    let provenanceText: String?
    let dimensions: String?
    let mediumDisplay: String?
    let placeOfOrigin: String?
    let description: String?

    // home init
    init(id: Int, title: String, artistTitle: String?, dateDisplay: String?, imageID: String?) {
        self.id = id
        self.title = title
        self.artistTitle = artistTitle
        self.dateDisplay = dateDisplay
        self.imageID = imageID
        self.provenanceText = nil
        self.dimensions = nil
        self.mediumDisplay = nil
        self.placeOfOrigin = nil
        self.description = nil
    }

    // details init
    init(
        id: Int,
        title: String,
        artistTitle: String?,
        dateDisplay: String?,
        imageID: String?,
        provenanceText: String?,
        dimensions: String?,
        mediumDisplay: String?,
        placeOfOrigin: String?,
        description: String?
    ) {
        self.id = id
        self.title = title
        self.artistTitle = artistTitle
        self.dateDisplay = dateDisplay
        self.imageID = imageID
        self.provenanceText = provenanceText
        self.dimensions = dimensions
        self.mediumDisplay = mediumDisplay
        self.placeOfOrigin = placeOfOrigin
        self.description = description
    }
}

struct ArtworkListDTO: Decodable {
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

struct ArtworkDetailDTO: Decodable {
    let id: Int
    let title: String
    let artistTitle: String?
    let dateDisplay: String?
    let imageID: String?
    let provenanceText: String?
    let dimensions: String?
    let mediumDisplay: String?
    let placeOfOrigin: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artistTitle = "artist_title"
        case dateDisplay = "date_display"
        case imageID = "image_id"
        case provenanceText = "provenance_text"
        case dimensions
        case mediumDisplay = "medium_display"
        case placeOfOrigin = "place_of_origin"
        case description
    }
}

struct ArtworkListResponse: Decodable {
    let data: [ArtworkListDTO]
}

struct ArtworkDetailResponse: Decodable {
    let data: ArtworkDetailDTO
}

// home DTO
extension ArtworkListDTO {
    func toDomain() -> Artwork {
        return Artwork(
            id: id,
            title: title,
            artistTitle: artistTitle,
            dateDisplay: dateDisplay,
            imageID: imageID
        )
    }
}

// details DTO
extension ArtworkDetailDTO {
    func toDomain() -> Artwork {
        return Artwork(
            id: id,
            title: title,
            artistTitle: artistTitle,
            dateDisplay: dateDisplay,
            imageID: imageID,
            provenanceText: provenanceText,
            dimensions: dimensions,
            mediumDisplay: mediumDisplay,
            placeOfOrigin: placeOfOrigin,
            description: description
        )
    }
}

// TODO: check if it works
extension Array where Element == ArtworkListDTO {
    func toDomain() -> [Artwork] {
        return self.map { $0.toDomain() }
    }
}
