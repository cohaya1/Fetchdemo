//
//  fetchdemoTests.swift
//  fetchdemoTests
//
//  Created by Chika Ohaya on 3/10/23.
//

import XCTest
@testable import fetchdemo

final class fetchdemoTests: XCTestCase {
    var sut: FetchViewModel!
    
    
    
    @MainActor override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        
        super.tearDown()
    }
     func compareExpectedToActualDesserts(_ expected: [DessertListsModelResponse],_ actual: [DessertListsModelResponse]) {
        XCTAssertEqual(expected.count, actual.count)
        
        //if the number elements are equal, then are they sorted alphabetically?
        for i in 0..<expected.count {
            let expectedMeal = expected[i]
            let actualMeal = actual[i]
            XCTAssertEqual(expectedMeal.name, actualMeal.name)
            XCTAssertEqual(expectedMeal.image, actualMeal.image)
            XCTAssertEqual(expectedMeal.id, actualMeal.id)
        }
    }
    
    func testGetAllDesserts_Success(_ expected: [DessertListsModelResponse],_ actual: [DessertListsModelResponse]) async  {
        // Given
        XCTAssertEqual(expected.count, actual.count)
        
        //if the number elements are equal, then are they sorted alphabetically?
        for i in 0..<expected.count {
            let expectedMeal = expected[i]
            let actualMeal = actual[i]
            XCTAssertEqual(expectedMeal.name, actualMeal.name)
            XCTAssertEqual(expectedMeal.image, actualMeal.image)
            XCTAssertEqual(expectedMeal.id, actualMeal.id)
        }
    }
    
    

    
}
