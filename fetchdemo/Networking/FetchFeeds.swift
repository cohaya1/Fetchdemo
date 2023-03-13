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
        }
    }
}




protocol FetchAPI {
    func getAllDessertsService() async throws -> DessertLists
    func getRecipesService() async throws -> RecipeMeals
    func handleNoInternetConnection()
 //   func getImage(from url: URL) async throws -> UIImage
    
}




// Define a class named "NetworkManager" that adopts the protocols "FetchAPI" and "ObservableObject"
class NetworkManager: FetchAPI, ObservableObject {
    
    
    
    
    
    
    
    
    func getRecipesService() async throws -> RecipeMeals {
        // Create a guard statement to ensure that the APIConstants baseUrl is a valid URL. If not, throw an "invalidURL" error.
        guard let url = URL(string: APIConstants.baseUrlLists) else {
            throw StatusCodes.invalidURL.localizedDescription
        }
        
        // Create a URLRequest with the URL and send a network request to retrieve data using URLSession.shared.
        // The retrieved data and response are returned as a tuple.
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Ensure that the response is an HTTPURLResponse with a status code of 200. If not, throw an "invalidResponse" error.
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw StatusCodes.invalidResponse.localizedDescription
        }
        
        // Attempt to decode the retrieved data into an array of "Restaurant" objects using JSONDecoder.
        // If successful, return the decoded array. If an error occurs during decoding, throw a "decodingError" error.
        do {
            let recipe = try JSONDecoder().decode(RecipeMeals.self, from: data)
            return recipe
        } catch {
            throw StatusCodes.decodingError.localizedDescription
        }
    }
    
    func handleNoInternetConnection() {
        print("No internet connection")
        // Show an alert or a message to the user indicating that there is no internet connection if I had more time I would show an alert for no internet connection
    }
    
    
    // Define an asynchronous function that retrieves all restaurants and returns an array of "Restaurant" objects
    func getAllDessertsService() async throws -> DessertLists{
        
        // Create a guard statement to ensure that the APIConstants baseUrl is a valid URL. If not, throw an "invalidURL" error.
        guard let url = URL(string: APIConstants.baseUrl) else {
            throw StatusCodes.invalidURL.localizedDescription
        }
        
        // Create a URLRequest with the URL and send a network request to retrieve data using URLSession.shared.
        // The retrieved data and response are returned as a tuple.
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Ensure that the response is an HTTPURLResponse with a status code of 200. If not, throw an "invalidResponse" error.
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw StatusCodes.invalidResponse.localizedDescription
        }
        
        // Attempt to decode the retrieved data into an array of "Restaurant" objects using JSONDecoder.
        // If successful, return the decoded array. If an error occurs during decoding, throw a "decodingError" error.
        do {
            let desserts = try JSONDecoder().decode(DessertLists.self, from: data)
            print(desserts)
            return desserts
        } catch {
            throw StatusCodes.decodingError.localizedDescription
        }
        
        
    }
//    private let cache = NSCache<NSString, UIImage>()
//    private let session = URLSession.shared
//
//    func getImage(from url: URL) async throws -> UIImage {
//        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
//            return cachedImage
//        }
//
//        let (data, response) = try await session.data(from: url)
//
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode),
//              let image = UIImage(data: data) else {
//            throw StatusCodes.invalidResponse.localizedDescription
//        }
//
//        cache.setObject(image, forKey: url.absoluteString as NSString)
//        return image
//    }
        }
        


