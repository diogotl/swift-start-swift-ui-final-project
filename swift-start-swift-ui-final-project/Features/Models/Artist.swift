//
//  Artist.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

struct Artist: Identifiable, Equatable, Hashable, Sendable {
    let id: Int
    let name: String
    let sortName: String?
    let isArtist: Bool
    let birthYear: Int?
    let deathYear: Int?
    let bio: String
}

extension ArtistDetailDTO {
    func toDomain() -> Artist {
        Artist(
            id: id,
            name: title ?? sortTitle ?? "sem nome",
            sortName: sortTitle,
            isArtist: isArtist ?? true,
            birthYear: birthDate,
            deathYear: deathDate,
            bio: description ?? "sem desc"
        )
    }
}

struct ArtistDetailDTO: Decodable {
    let id: Int
    let title: String?
    let sortTitle: String?
    let isArtist: Bool?
    let birthDate: Int?
    let deathDate: Int?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case sortTitle = "sort_title"
        case isArtist = "is_artist"
        case birthDate = "birth_date"
        case deathDate = "death_date"
        case description
    }
}

struct ArtistDetailResponse: Decodable {
    let data: ArtistDetailDTO
}
