//
//  fetchdemoTests.swift
//  fetchdemoTests
//
//  Created by Chika Ohaya on 3/10/23.
//

import XCTest
@testable import fetchdemo

final class fetchdemoTests: XCTestCase {
    var sut: FetchListFetcher!
    
        var mockService: MockFetchAPI!

    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
                mockService = MockFetchAPI()
                sut = FetchListFetcher(service: mockService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
                sut = nil
                mockService = nil
                   super.tearDown()
    }

    
    func testGetAllMeals_Success() async  {
        // Given
        let expectedDessertLists = DessertLists()
        mockService.expectedDessertLists = expectedDessertLists
        mockService.shouldReturnError = false

        // When
        await sut.getAllMeals()

        // Then
        // Then
 let result = await MainActor.run { sut.meal }
     XCTAssertEqual(result, expectedDessertLists)
        
        

    }
  

   

     func testGetAllRecipe_Success() async  {
        // Given
        let expectedRecipeMeals = RecipeMeals()
        mockService.expectedRecipeMeals = expectedRecipeMeals
        mockService.shouldReturnError = false

                // When
                await sut.getRecipes()

                // Then
         let result = await MainActor.run { sut.instructions }
             XCTAssertEqual(result, expectedRecipeMeals)
    }
}
final class MockFetchAPI: FetchAPI {
    
    var shouldReturnError = false
    var expectedDessertLists: DessertLists?
    var expectedRecipeMeals: RecipeMeals?
    
    func getAllDessertsService() async throws -> DessertLists {
            if let expectedDessertLists = expectedDessertLists {
                return expectedDessertLists
            } else if shouldReturnError {
                throw StatusCodes.failure.localizedDescription
            } else {
                fatalError("Expected dessert lists not set")
            }
        }
    
    func getRecipesService() async throws -> RecipeMeals {
        if let expectedRecipeMeals = expectedRecipeMeals {
            return expectedRecipeMeals
        } else {
            throw StatusCodes.failure.localizedDescription
        }
    }
    
    func handleNoInternetConnection() {
        print("No internet connection.")
    }
}
