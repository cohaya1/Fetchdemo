//
//  FetchViewModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//
import SwiftUI
import Foundation
import Network


// FetchViewModel is a class that conforms to the ObservableObject protocol and is marked with the MainActor attribute.
// This class is responsible for managing API calls and data manipulation for the user interface.
@MainActor
final class FetchViewModel: ObservableObject {
    // A private instance of the FetchAPI protocol, which is used to fetch data from the network.
    private let fetchAPI: FetchAPI

    // Initialize the FetchViewModel with a custom or default FetchAPI instance.
    init(using fetchMock: FetchAPI = NetworkManager()) {
        self.fetchAPI = fetchMock
    }

    // Fetch all desserts for a specific category and filter and sort them before returning.
    func getAllDessertsService(for category: Category) async throws -> [DessertListsModelResponse] {
        // Fetch the desserts from the API.
        let meals = try await fetchAPI.getAllDessertsService(for: category)

        // Filter out meals with empty names and sort them alphabetically.
        let filteredMeals = meals.filter {
            !$0.name.isEmpty
        }
        .sorted {
            $0.name.lowercased() < $1.name.lowercased()
        }

        return filteredMeals
    }

    // Fetch the recipe details for a specific meal ID, filter the ingredients, and return the modified recipe object.
    func getRecipesService(id: Int) async throws -> RecipeMealsDetailsResponse {
        let recipes = try await fetchAPI.getRecipesService(id: id)

        // Filter out ingredients with empty names and quantities.
        let filteredingredients = recipes.ingredients.filter {
            !$0.name.isEmpty && !$0.quantity.isEmpty
        }

        // Create a new RecipeMealsDetailsResponse object with the filtered ingredients.
        let filteredrecipes = RecipeMealsDetailsResponse(name: recipes.name, instructions: recipes.instructions, ingredients: filteredingredients)
        return filteredrecipes
    }

    // Check for internet connection and throw an error if there's no connection.
    func handleNoInternetConnection() async throws {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")

        // Check for an active internet connection and return a boolean value or throw an error.
        let connectionAvailable = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Bool, Error>) in
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    continuation.resume(returning: true)
                } else {
                    continuation.resume(throwing: StatusCodes.nointernetconnection)
                }
            }
            monitor.start(queue: queue)
        }

        // If the connection is not available, throw a "no internet connection" error.
        if !connectionAvailable {
            throw StatusCodes.nointernetconnection
        }
    }
}
