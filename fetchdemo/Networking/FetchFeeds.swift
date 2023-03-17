// `FetchFeeds.swift`
// `fetchdemo`
//
// Created by Chika Ohaya on 3/17/23.
//

import Foundation
import SwiftUI

// Define an enum `StatusCodes` to represent various error states that might occur during API calls.
enum StatusCodes: Error {
    case failure
    case invalidURL
    case invalidResponse
    case decodingError
    case nointernetconnection

    // Provide a localized description for each error case.
    
    var localizedDescription: Error {
        switch self {
        case .failure:
            return "Failure" as! Error
        case .invalidURL:
            return "Invalid URL" as! Error
        case .invalidResponse:
            return "Invalid response from the server" as! Error
        case .decodingError:
            return "Error in decoding the data" as! Error
        case .nointernetconnection:
            return "No connection available" as! Error
        }
    }
}

// Define the `FetchAPI` protocol which outlines methods required for fetching dessert and recipe data.
protocol FetchAPI {
    func getAllDessertsService(for category: Category) async throws -> [DessertListsModelResponse]
    func getRecipesService(id: Int) async throws -> RecipeMealsDetailsResponse
}

// Define the `NetworkManager` class, which conforms to both `FetchAPI` and `ObservableObject` protocols.
class NetworkManager: FetchAPI, ObservableObject {
    
    // Fetch the recipe details for a specific meal ID and return a `RecipeMealsDetailsResponse` object.
    func getRecipesService(id: Int) async throws -> RecipeMealsDetailsResponse {
        let endpoint = APIConstants.getDessertsDetails(id: id)
        let urlComposer = UrlComposer()
        let url =  urlComposer.getURL(for: endpoint)!
        typealias RecipeResponse = DessertsLists<[Recipe]>

        // Fetch the recipe details from the API and extract ingredients and measurements.
        let response: RecipeResponse = try await urlComposer.makeRequest(at: url)
        let responseDetails = response.meals[0]
        let ingredientsAndMeasurements = extractIngredientsAndMeasurements(from: responseDetails)
        let ingredients = ingredientsAndMeasurements.map { Ingredient(name: $0.0, quantity: $0.1) }

        // Create a `RecipeMealsDetailsResponse` object with the fetched and processed data.
        let mealDetails = RecipeMealsDetailsResponse(name: responseDetails.name, instructions: responseDetails.instructions, ingredients: ingredients)
        return mealDetails
    }
    
    // Fetch all desserts for a specific category and return an array of `DessertListsModelResponse` objects.
    func getAllDessertsService(for category: Category) async throws -> [DessertListsModelResponse] {
        var meals = [DessertListsModelResponse]()
        switch category {
        case .dessert:
            let endPoint = APIConstants.getDesserts(category: .dessert)
            let urlComposer = UrlComposer()
            let url =  urlComposer.getURL(for: endPoint)!
            typealias MealResponse = DessertsLists<[Meal]>

            // Fetch the dessert data from the API.
            let response: MealResponse = try await urlComposer.makeRequest(at: url)
            let responseMeals = response.meals

            // Map the fetched data to `DessertListsModelResponse` objects.
            meals = responseMeals.compactMap { responseMeal -> DessertListsModelResponse? in
                guard let mealId = Int(responseMeal.idMeal) else {
                    return nil
                }
                return DessertListsModelResponse(name: responseMeal.strMeal, image: responseMeal.strMealThumb,  id: mealId )
                    }
                }
                
                return meals
            }
            
        }
       
   

    
// Define a function to extract ingredients and measurements from a Recipe object.
func extractIngredientsAndMeasurements(from details: Recipe) -> [(String, String)] {
    let ingredientsAndMeasurements: [(String?, String?)] = [
        (details.ingredient1, details.measurement1),
        (details.ingredient2, details.measurement2),
        (details.ingredient3, details.measurement3),
        (details.ingredient4, details.measurement4),
        (details.ingredient5, details.measurement5),
        (details.ingredient6, details.measurement6),
        (details.ingredient7, details.measurement7),
        (details.ingredient8, details.measurement8),
        (details.ingredient9, details.measurement9),
        (details.ingredient10, details.measurement10),
        (details.ingredient11, details.measurement11),
        (details.ingredient12, details.measurement12),
        (details.ingredient13, details.measurement13),
        (details.ingredient14, details.measurement14),
        (details.ingredient15, details.measurement15),
        (details.ingredient16, details.measurement16),
        (details.ingredient17, details.measurement17),
        (details.ingredient18, details.measurement18),
        (details.ingredient19, details.measurement19),
        (details.ingredient20, details.measurement20)
    ]
    // Filter and return a tuple of non-empty ingredient names and measurements.

    return ingredientsAndMeasurements.compactMap { (ingredient, measurement) in
        if let ingredient = ingredient, let measurement = measurement, !ingredient.isEmpty {
            return (ingredient, measurement)
        } else {
            return nil
        }
    }
}

    

