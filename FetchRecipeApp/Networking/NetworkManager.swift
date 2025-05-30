//
//  NetworkManager.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Error)
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL: String

    init(baseURL: String = "https://d3jbb8n5wk0qxi.cloudfront.net") {
        self.baseURL = baseURL
    }

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "\(baseURL)/recipes.json") else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }

        do {
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return recipeResponse.recipes
        } catch {
            throw NetworkError.decodingError
        }
    }
}

