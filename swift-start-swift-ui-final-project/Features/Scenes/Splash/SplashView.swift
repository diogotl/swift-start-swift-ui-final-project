//
//  SplashView.swift
//  swift-start-swift-ui-final-project
//
//  Created by Diogo on 01/03/2026.
//

import SwiftUI

struct SplashView: View {
    @State private var appear = false

    var body: some View {
        ZStack {
            Colors.brown200
                .ignoresSafeArea()

            Image("artic-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 277)
                .opacity(appear ? 1 : 0)
                .scaleEffect(appear ? 1.0 : (0.90))
                .accessibilityLabel("logo")
        }
        .task {
            withAnimation(animation) {
                appear = true
            }
        }
    }

    private var animation: Animation {
        return .spring(response: 0.6, dampingFraction: 0.8)
    }
}

#Preview {
    SplashView()
}
