//
//  FetchRecipeAppTests.swift
//  FetchRecipeAppTests
//
//  Created by Erikneon on 5/30/25.
//
import XCTest
@testable import FetchRecipeApp

final class FetchRecipeAppTests: XCTestCase {
    // Convert Testing framework tests to XCTest format
    
    // MARK: - NetworkError Tests
     
     func test_NetworkError_Cases() {
         let errors: [NetworkError] = [
             .invalidURL,
             .invalidResponse,
             .decodingError,
             .serverError(NSError(domain: "test", code: 500))
         ]
         
         XCTAssertEqual(errors.count, 4)
     }
    
    // MARK: - 
    func test_RecipeResponse_HandlesEmptyArray() {
          let json = "{ \"recipes\": [] }"
          let data = json.data(using: .utf8)!
          let response = try? JSONDecoder().decode(RecipeResponse.self, from: data)
          
          XCTAssertNotNil(response)
          XCTAssertTrue(response?.recipes.isEmpty ?? false)
      }
}
