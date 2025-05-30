//
//  RecipeViewModel.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let networkManager = NetworkManager.shared
    
    func fetchRecipes() async {
        isLoading = true
        error = nil
        
        do {
            recipes = try await networkManager.fetchRecipes()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func refreshRecipes() {
        Task {
            await fetchRecipes()
        }
    }
} 
