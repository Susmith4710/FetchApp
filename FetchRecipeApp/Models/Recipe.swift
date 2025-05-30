//
//  FetchRecipeAppApp.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURLSmall: String?
    let photoURLLarge: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
} 
