//
//  Exhibition.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import Foundation

struct Exhibition: Identifiable {
    let id: Int
    let title: String
    let imageUrl: String?
    let status: String?
    let galleryTitle: String?

    var isActive: Bool {
        status == "Confirmed"
    }

    var statusDisplayText: String {
        status ?? "Unknown"
    }
}

// MARK: - DTO
struct ExhibitionDTO: Decodable {
    let id: Int
    let title: String
    let imageUrl: String?
    let status: String?
    let galleryTitle: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageUrl = "image_url"
        case status
        case galleryTitle = "gallery_title"
    }
}

extension ExhibitionDTO {
    func toDomain() -> Exhibition {
        Exhibition(
            id: id,
            title: title,
            imageUrl: imageUrl,
            status: status,
            galleryTitle: galleryTitle
        )
    }
}

extension Array where Element == ExhibitionDTO {
    func toDomain() -> [Exhibition] {
        map { $0.toDomain() }
    }
}

// MARK: - Response
struct ExhibitionListResponse: Decodable {
    let data: [ExhibitionDTO]
}

struct ExhibitionDetailResponse: Decodable {
    let data: ExhibitionDTO
}
