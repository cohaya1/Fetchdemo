//
//  FetchFeeds.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import Foundation
import SwiftUI

// Create an enum so for diffent methods for http fucntionality to pass around other functions
enum StatusCodes: Error {
    
    case failure
    case invalidURL
    case invalidResponse
    case decodingError
    case nointernetconnection
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




protocol FetchAPI {
    func getAllDessertsService(for category: Category) async throws -> [DessertModel]
    func getRecipesService(id: Int) async throws -> MealDetail
    
    
 //   func getImage(from url: URL) async throws -> UIImage
    
}




// Define a class named "NetworkManager" that adopts the protocols "FetchAPI" and "ObservableObject"
class NetworkManager: FetchAPI, ObservableObject {
    
    func getRecipesService(id: Int) async throws -> MealDetail {
        let endpoint = APIConstants.getDessertsDetails(id: id)
        let urlComposer = UrlComposer()
        let url =  urlComposer.getURL(for: endpoint)!
        typealias RecipeResponse = DessertsLists<[Recipe]>
        // Create a URLRequest with the URL and send a network request to retrieve data using URLSession.shared.
        // The retrieved data and response are returned as a tuple.
        let response: RecipeResponse = try await urlComposer.makeRequest(at: url)
          
        let responseDetails = response.meals[0]
            
            
        
        
        
        

        let ingredientsAndMeasurements = extractIngredientsAndMeasurements(from: responseDetails)
           let ingredients = ingredientsAndMeasurements.map { Ingredient(name: $0.0, quantity: $0.1) }
        

        let mealDetails = MealDetail(name: responseDetails.name,
                                          instructions: responseDetails.instructions,
                                          ingredients: ingredients)
            
        // Ensure that the response is an HTTPURLResponse with a status code of 200. If not, throw an "invalidResponse" error.
        
        
        // Attempt to decode the retrieved data into an array of "Restaurant" objects using JSONDecoder.
        // If successful, return the decoded array. If an error occurs during decoding, throw a "decodingError" error.
       return mealDetails
    }
    
   
    
    
    
    
   
    
    
    func getAllDessertsService(for category: Category) async throws -> [DessertModel] {
        // Create a guard statement to ensure that the APIConstants baseUrl is a valid URL. If not, throw an "invalidURL" error.
        var meals = [DessertModel]()
        switch category {
        case .dessert:
            let endPoint = APIConstants.getDesserts(category: .dessert)
            let urlComposer = UrlComposer()
            let url =  urlComposer.getURL(for: endPoint)!
            typealias MealResponse = DessertsLists<[Meal]>
            
            let response: MealResponse = try await urlComposer.makeRequest(at: url)
           
            let responseMeals = response.meals
            
            meals = responseMeals.compactMap { responseMeal -> DessertModel? in
                        guard let mealId = Int(responseMeal.idMeal) else {
                            return nil
                        }
                return DessertModel(name: responseMeal.strMeal, image: responseMeal.strMealThumb,  id: mealId )
                    }
                }
                
                return meals
            }
            
        }
       
   

    
       
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

    return ingredientsAndMeasurements.compactMap { (ingredient, measurement) in
        if let ingredient = ingredient, let measurement = measurement, !ingredient.isEmpty {
            return (ingredient, measurement)
        } else {
            return nil
        }
    }
}

    // Define an asynchronous function that retrieves all desserts and returns an array of "Dessert" objects
    

