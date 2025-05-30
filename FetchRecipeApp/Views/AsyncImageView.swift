//
//  AsyncImageView.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import SwiftUI
import UIKit

struct AsyncImageView: View {
    let url: URL?
    let placeholder: () -> AnyView
    let content: (Image) -> AnyView
    
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let image = image {
                content(Image(uiImage: image))
            } else if isLoading {
                placeholder()
            } else {
                placeholder()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        
        isLoading = true
        Task {
            do {
                let loadedImage = try await ImageCache.shared.image(for: url)
                await MainActor.run {
                    self.image = loadedImage
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
