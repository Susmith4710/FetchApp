# Fetch Recipe App

A SwiftUI-based recipe app that displays recipes from the Fetch API.

## Features

- Display list of recipes with images and cuisine types
- Pull-to-refresh functionality
- Detailed recipe view with large images
- Links to original recipe and YouTube videos
- Custom image caching implementation
- Error handling for malformed data and empty states
- Unit tests for network layer

## Technical Implementation

### Architecture
- MVVM architecture pattern
- SwiftUI for UI implementation
- Async/await for asynchronous operations
- Custom image caching system
- No third-party dependencies

### Key Components

1. **Models**
   - `Recipe`: Codable model for recipe data
   - `RecipeResponse`: Container for API response

2. **Networking**
   - `NetworkManager`: Handles API requests
   - `ImageCache`: Custom image caching implementation

3. **ViewModels**
   - `RecipeViewModel`: Manages recipe data and state

4. **Views**
   - `RecipeListView`: Main list view
   - `RecipeDetailView`: Detailed recipe view
   - `RecipeRowView`: List item view
   - `ErrorView`: Error state view
   - `EmptyStateView`: Empty state view

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Testing

The project includes unit tests for the network layer, covering:
- Successful recipe fetching
- Error handling for malformed data
- Image caching functionality

## Focus Areas

1. **Performance**
   - Efficient image loading and caching
   - Minimal memory usage
   - Smooth scrolling experience

2. **User Experience**
   - Clean and intuitive interface
   - Responsive UI
   - Clear error states
   - Pull-to-refresh functionality

3. **Code Quality**
   - Clean architecture
   - Type safety
   - Error handling
   - Unit tests

## Additional Information

The app follows all the requirements specified in the project guidelines:
- Uses Swift Concurrency (async/await)
- No external dependencies
- Custom image caching implementation
- SwiftUI for UI
- iOS 16+ support
- Comprehensive error handling 
