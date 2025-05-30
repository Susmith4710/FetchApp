//
//  RecipeListView.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//


import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    ErrorView(error: error) {
                        viewModel.refreshRecipes()
                    }
                } else if viewModel.recipes.isEmpty {
                    EmptyStateView {
                        viewModel.refreshRecipes()
                    }
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRowView(recipe: recipe)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchRecipes()
                    }
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.refreshRecipes()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
    }
}

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            if let urlString = recipe.photoURLSmall,
               let url = URL(string: urlString) {
                // Replace AsyncImage with:
                AsyncImageView(
                    url: url,
                    placeholder: {
                        AnyView(ProgressView())
                    },
                    content: { image in
                        AnyView(
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        )
                    }
                )
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Error loading recipes")
                .font(.headline)
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct EmptyStateView: View {
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .font(.largeTitle)
            Text("No recipes available")
                .font(.headline)
            Button("Refresh") {
                retryAction()
            }
            .buttonStyle(.bordered)
        }
    }
}
