//
//  LazyImage.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 04/03/2026.
//

import SwiftUI

struct LazyImage: View {

    let imageID: String?
    @State private var loadedImage: UIImage?
    @State private var isLoading = true

    var body: some View {
        Group {
            if let loadedImage = loadedImage {
                Image(uiImage: loadedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Colors.neutral200, Colors.neutral300,
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay(
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Colors.neutral600)
                        )
                )
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Colors.neutral200, Colors.neutral300,
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay(
                    Image(systemName: "photo")
                        .font(Typography.headingMd)
                        .foregroundStyle(Colors.neutral400)
                )
            }
        }
        .onAppear {
            if let imageID = imageID {
                loadImage(imageID: imageID)
            } else {
                isLoading = false
            }
        }
    }

    private func loadImage(imageID: String) {
        Task {
            guard
                let url = URL(
                    string:
                        "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg"
                )
            else {
                isLoading = false
                return
            }

            var request = URLRequest(url: url)
            request.setValue(
                "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1",
                forHTTPHeaderField: "User-Agent"
            )
            request.setValue(
                "https://www.artic.edu",
                forHTTPHeaderField: "Referer"
            )

            guard
                let (data, _) = try? await URLSession.shared.data(for: request),
                let image = UIImage(data: data)
            else {
                await MainActor.run {
                    isLoading = false
                }
                return
            }

            await MainActor.run {
                loadedImage = image
                isLoading = false
            }
        }
    }
}
