//
//  ExhibitionCard.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 08/03/2026.
//

import SwiftUI

struct ExhibitionCard: View {
    let exhibition: Exhibition

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                if let imageUrl = exhibition.imageUrl, !imageUrl.isEmpty {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .empty:
                            Colors.neutral200.overlay(ProgressView())
                        default:
                            Colors.neutral200.overlay(
                                Image(systemName: "building.columns")
                                    .font(.system(size: 32))
                                    .foregroundStyle(Colors.neutral400)
                            )
                        }
                    }
                } else {
                    Colors.neutral200.overlay(
                        Image(systemName: "building.columns")
                            .font(.system(size: 32))
                            .foregroundStyle(Colors.neutral400)
                    )
                }
            }
            .frame(width: 280, height: 360)
            .clipped()

            VStack(alignment: .leading, spacing: Spacing.xsSmall) {
                HStack(spacing: Spacing.xsSmall) {
                    Circle()
                        .fill(
                            exhibition.isActive
                                ? Colors.emerald500 : Colors.neutral400
                        )
                        .frame(width: 6, height: 6)
                    Text(exhibition.statusDisplayText.uppercased())
                        .font(Typography.bodyXs)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            exhibition.isActive
                                ? Colors.emerald500 : Colors.neutral500
                        )
                    Spacer()
                }

                Text(exhibition.title)
                    .font(Typography.headingSm)
                    .foregroundStyle(Colors.neutral900)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                if let gallery = exhibition.galleryTitle {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 10))
                        Text(gallery)
                            .font(Typography.bodyXs)
                            .lineLimit(1)
                    }
                    .foregroundStyle(Colors.neutral500)
                }
            }
            .padding(Spacing.medium)
            .frame(width: 280, height: 110, alignment: .topLeading)
            .background(Colors.neutral50)
        }
        .frame(width: 280)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Colors.neutral200, lineWidth: 1)
        )
    }
}
