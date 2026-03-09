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

    let artistIDs: [Int]?

    // artwork detail
    let provenanceText: String?
    let dimensions: String?
    let mediumDisplay: String?
    let placeOfOrigin: String?
    let description: String?
    let artworkTypeTitle: String?
    let departmentTitle: String?
    let styleTitle: String?
    let classificationTitle: String?
    let isPublicDomain: Bool?

    // home init
    init(
        id: Int,
        title: String,
        artistTitle: String?,
        dateDisplay: String?,
        placeOfOrigin: String?,
        imageID: String?,
        artistIDs: [Int]? = nil,
        artworkTypeTitle: String? = nil
    ) {
        self.id = id
        self.title = title
        self.artistTitle = artistTitle
        self.dateDisplay = dateDisplay
        self.imageID = imageID
        self.provenanceText = nil
        self.dimensions = nil
        self.mediumDisplay = nil
        self.placeOfOrigin = placeOfOrigin
        self.description = nil
        self.artistIDs = artistIDs
        self.artworkTypeTitle = artworkTypeTitle
        self.departmentTitle = nil
        self.styleTitle = nil
        self.classificationTitle = nil
        self.isPublicDomain = nil
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
        description: String?,
        artistIDs: [Int]? = nil,
        artworkTypeTitle: String? = nil,
        departmentTitle: String? = nil,
        styleTitle: String? = nil,
        classificationTitle: String? = nil,
        isPublicDomain: Bool? = nil
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
        self.artistIDs = artistIDs
        self.artworkTypeTitle = artworkTypeTitle
        self.departmentTitle = departmentTitle
        self.styleTitle = styleTitle
        self.classificationTitle = classificationTitle
        self.isPublicDomain = isPublicDomain
    }
}

struct ArtworkListDTO: Decodable {
    let id: Int
    let title: String
    let artistTitle: String?
    let dateDisplay: String?
    let placeOfOrigin: String?
    let imageID: String?
    let artworkTypeTitle: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case artistTitle = "artist_title"
        case dateDisplay = "date_display"
        case imageID = "image_id"
        case placeOfOrigin = "place_of_origin"
        case artworkTypeTitle = "artwork_type_title"
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
    let artistIDs: [Int]?
    let artworkTypeTitle: String?
    let departmentTitle: String?
    let styleTitle: String?
    let classificationTitle: String?
    let isPublicDomain: Bool?

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
        case artistIDs = "artist_ids"
        case artworkTypeTitle = "artwork_type_title"
        case departmentTitle = "department_title"
        case styleTitle = "style_title"
        case classificationTitle = "classification_title"
        case isPublicDomain = "is_public_domain"
    }
}

struct PaginationInfo: Decodable {
    let total: Int
    let limit: Int
    let offset: Int
    let totalPages: Int
    let currentPage: Int

    enum CodingKeys: String, CodingKey {
        case total
        case limit
        case offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
}

struct ArtworkListResponse: Decodable {
    let pagination: PaginationInfo?
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
            placeOfOrigin: placeOfOrigin,
            imageID: imageID,
            artistIDs: nil,
            artworkTypeTitle: artworkTypeTitle
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
            description: description,
            artistIDs: artistIDs,
            artworkTypeTitle: artworkTypeTitle,
            departmentTitle: departmentTitle,
            styleTitle: styleTitle,
            classificationTitle: classificationTitle,
            isPublicDomain: isPublicDomain
        )
    }
}

// TODO: check if it works
extension Array where Element == ArtworkListDTO {
    func toDomain() -> [Artwork] {
        return self.map { $0.toDomain() }
    }
}
