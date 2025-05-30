//
//  RecipeDetailView.swift
//  FetchRecipeApp
//
//  Created by Erikneon on 5/30/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero Image Section
                ZStack(alignment: .bottomLeading) {
                    if let urlString = recipe.photoURLLarge,
                       let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .background(Color.gray.opacity(0.2))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                    }
                    
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 300)
                    
                    // Title overlay
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.name)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text(recipe.cuisine)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding()
                }
                
                // Content Section
                VStack(alignment: .leading, spacing: 24) {
                    // Links Section
                    VStack(alignment: .leading, spacing: 16) {
                        if let sourceURL = recipe.sourceURL,
                           let url = URL(string: sourceURL) {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "link")
                                    Text("View Original Recipe")
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                }
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(12)
                            }
                        }
                        
                        if let youtubeURL = recipe.youtubeURL,
                           let url = URL(string: youtubeURL) {
                            Link(destination: url) {
                                HStack {
                                    Image(systemName: "play.circle.fill")
                                    Text("Watch on YouTube")
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                }
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .foregroundColor(.red)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
} 
