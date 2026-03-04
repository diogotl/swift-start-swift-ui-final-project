//
//  ArtworkCardView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import SwiftUI

struct ArtworkCardView: View {
    let artwork: Artwork

    var body: some View {
        VStack(spacing: 0) {
            LazyImage(imageID: artwork.imageID)
                .frame(height: 320)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            VStack(alignment: .leading, spacing: Spacing.xsSmall) {
                HStack(alignment: .firstTextBaseline) {
                    Text(artwork.title)
                        .font(Typography.headingMd)
                        .foregroundStyle(Colors.neutral900)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Spacer(minLength: 8)

                    Text(artwork.artworkTypeTitle ?? "Artwork")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Colors.neutral700)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Colors.neutral100)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(Colors.neutral200, lineWidth: 1)
                        )
                }

                Text(artwork.artistTitle ?? "Artist")
                    .font(Typography.bodySm)
                    .foregroundStyle(Colors.neutral500)
                    .lineLimit(3)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Colors.neutral50)
            .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Colors.neutral200)
                .frame(height: 1)
        }
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Colors.neutral100)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Colors.neutral200, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}
