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
        VStack {
            Text(title)
            Text(value)
        }
    }
}
