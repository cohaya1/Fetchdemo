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
    private func compareExpectedToActualMeals(_ expected: [DessertModel],_ actual: [DessertModel]) {
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
    
    func testGetAllMeals_Success(_ expected: [DessertModel],_ actual: [DessertModel]) async  {
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
    
    
//    private func makeRequestToGetActualMeals(_ expectedMeals:[DessertModel]) {
//        let expectation = expectation(description: "Expectation for meals")
//        sut.getAllDessertsService(for: .dessert) { actualMeals in
//            //assert
//            self.compareExpectedToActualMeals(expectedMeals, actualMeals)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.1)
//    }
    
}
