//
//  String+Extension.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//
import Foundation

extension String {
    func stripHTML() -> String {
        self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }
}
