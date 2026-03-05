//
//  Badge.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 05/03/2026.
//

import SwiftUI

enum BadgeVariant {
    case primary
    case secondary
}

struct Badge: View {
    let text: String
    var variant: BadgeVariant

    var body: some View {
        Text(text)
            .font(Typography.bodySm)
            .foregroundStyle(
                variant == .primary ? Colors.neutral700 : Colors.neutral600
            )
            .padding(.horizontal, Spacing.small)
            .padding(.vertical, Spacing.xsSmall)
            .background(variant == .primary ? Colors.neutral100 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: Spacing.xsSmall))
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.xsSmall)
                    .stroke(Colors.neutral300, lineWidth: 1)
            )
    }
}
