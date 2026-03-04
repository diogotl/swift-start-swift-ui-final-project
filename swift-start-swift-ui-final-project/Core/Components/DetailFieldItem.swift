//
//  DetailFieldItem.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct DetailFieldItem: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xsSmall) {
            Text(title)
                .font(Typography.bodyXs)
                .foregroundStyle(Colors.neutral500)
                .textCase(.uppercase)
                .tracking(0.5)

            Text(value)
                .font(Typography.bodySm)
                .foregroundStyle(Colors.neutral900)
        }
    }
}
