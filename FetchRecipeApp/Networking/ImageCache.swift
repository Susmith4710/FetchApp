//
//  ImageCache.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import Foundation
import UIKit

actor ImageCache {
    static let shared = ImageCache()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheDirectory = cachesDirectory.appendingPathComponent("RecipeImages")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    private func cacheKey(for url: URL) -> String {
        return url.absoluteString.replacingOccurrences(of: "/", with: "_")
    }
    
    private func fileURL(for key: String) -> URL {
        return cacheDirectory.appendingPathComponent(key)
    }
    
    func image(for url: URL) async throws -> UIImage {
        let key = cacheKey(for: url)
        let fileURL = fileURL(for: key)
        
        // Check if image exists in cache
        if fileManager.fileExists(atPath: fileURL.path) {
            if let data = try? Data(contentsOf: fileURL),
               let image = UIImage(data: data) {
                return image
            }
        }
        
        // Download and cache image
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidResponse
        }
        
        try data.write(to: fileURL)
        return image
    }
    
    func clearCache() throws {
        try fileManager.removeItem(at: cacheDirectory)
        try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
} 
