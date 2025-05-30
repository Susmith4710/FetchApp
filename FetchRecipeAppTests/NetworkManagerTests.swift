//
//  NetworkManagerTests.swift
//  FetchRecipeAppTests
//
//  Created by Erikneon on 5/31/25.
//

import XCTest
@testable import FetchRecipeApp

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchRecipes() async throws {
        // Given
        let expectation = XCTestExpectation(description: "Fetch recipes")
        
        // When
        do {
            let recipes = try await networkManager.fetchRecipes()
            
            // Then
            XCTAssertFalse(recipes.isEmpty, "Recipes array should not be empty")
            expectation.fulfill()
        } catch {
            XCTFail("Failed to fetch recipes: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testFetchRecipesWithMalformedData() async {
        let malformedManager = NetworkManager(baseURL: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")
        let expectation = XCTestExpectation(description: "Expect decoding to fail")
        
        do {
            _ = try await malformedManager.fetchRecipes()
            XCTFail("Expected decoding to fail, but succeeded.")
        } catch {
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }

}
