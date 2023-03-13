//
//  ModelTests.swift
//  fetchdemoTests
//
//  Created by Chika Ohaya on 3/13/23.
//

import XCTest
@testable import fetchdemo

final class ModelTests: XCTestCase {
    var sut: DessertLists!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DessertLists()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testDessertListsDecoding() throws {
        // Given
        let jsonString = """
            {
                "meals": [
                    {
                        "strMeal": "Chocolate Cake",
                        "strMealThumb": "https://www.example.com/chocolate-cake.jpg",
                        "idMeal": "1"
                    },
                    {
                        "strMeal": "Apple Pie",
                        "strMealThumb": "https://www.example.com/apple-pie.jpg",
                        "idMeal": "2"
                    }
                ]
            }
        """
        let data = Data(jsonString.utf8)

        
        // When
        let result = try JSONDecoder().decode(DessertLists.self, from: data)
        
        // Then
        XCTAssertEqual(result.meals.count, 2)
        XCTAssertEqual(result.meals[0].strMeal, "Chocolate Cake")
        XCTAssertEqual(result.meals[0].strMealThumb, "https://www.example.com/chocolate-cake.jpg")
        XCTAssertEqual(result.meals[0].idMeal, "1")
        XCTAssertEqual(result.meals[1].strMeal, "Apple Pie")
        XCTAssertEqual(result.meals[1].strMealThumb, "https://www.example.com/apple-pie.jpg")
        XCTAssertEqual(result.meals[1].idMeal, "2")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
