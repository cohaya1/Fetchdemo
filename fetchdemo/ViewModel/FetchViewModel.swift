//
//  FetchViewModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//
import SwiftUI
import Foundation
import Network

// Protocol `SchoolListViewModel` is defined with a single function `getAllSchools` which is async

    

   


// The class `SchoolListFetcher` is marked with `MainActor` which is a keyword in Swift for Actors.
// The `SchoolListFetcher` class implements the `SchoolListViewModel` protocol and conforms to it.
@MainActor
final class FetchViewModel: ObservableObject  {
    private let fetchAPI: FetchAPI
    
    init(using fetchMock: FetchAPI = NetworkManager()) {
        self.fetchAPI = fetchMock
    }
    func getAllDessertsService(for category: Category) async throws -> [DessertModel] {
        let meals = try await fetchAPI.getAllDessertsService(for: category)
        let filteredMeals = meals.filter {
            !$0.name.isEmpty
        }
            .sorted {
                $0.name.lowercased() < $1.name.lowercased()
            }
        return filteredMeals
    }
    
    func getRecipesService(id: Int) async throws -> MealDetail {
        let recipes = try await fetchAPI.getRecipesService(id: id)
        let filteredingredients = recipes.ingredients.filter {
            !$0.name.isEmpty && !$0.quantity.isEmpty
        }
        let filteredrecipes = MealDetail(name: recipes.name,instructions: recipes.instructions
                                         , ingredients: filteredingredients)
        return filteredrecipes
        
    }
    
    func handleNoInternetConnection() async throws {
        let monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "NetworkMonitor")
            
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
            
            if !connectionAvailable {
                throw StatusCodes.nointernetconnection
            }
    }
    
    
    
    
    
    // The `schools` property is marked with `@Published` which means it will be observed by any view that uses it.
   
    }
