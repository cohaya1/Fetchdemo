//
//  FetchViewModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//
import SwiftUI
import Foundation


// Protocol `SchoolListViewModel` is defined with a single function `getAllSchools` which is async
protocol FetchViewModel: ObservableObject {
    func getAllMeals() async
    func getRecipes() async
   
}

// The class `SchoolListFetcher` is marked with `MainActor` which is a keyword in Swift for Actors.
// The `SchoolListFetcher` class implements the `SchoolListViewModel` protocol and conforms to it.
@MainActor
final class FetchListFetcher: FetchViewModel  {
    
    
    
    // The `schools` property is marked with `@Published` which means it will be observed by any view that uses it.
    // The `schools` property is an array of `SchoolsDataModel` objects.
    @Published var meal = DessertLists()
    @Published var instructions = RecipeMeals()
    @Published var image: UIImage?
    

    // `service` property is a private constant which holds the instance of `FetchAPI`.
    private let service: FetchAPI
    
    // Initializer which takes `service` as a parameter and assigns it to the `service` property.
    init(service: FetchAPI ) {
        self.service = service
    }
    
    // `getAllSchools` function is defined in the protocol.
    // This function fetches all the schools data from the API and populates the `schools` array.
    // If there is an error, it will print the error and handle no internet connection error if needed.
    func getRecipes() async {
        do {
            
            // Try to fetch the schools data from the API.
            instructions = try await service.getRecipesService()
            
        } catch {
            // If there is an error, print the error message.
            print("Error can't return any data: \(error)")
            
            // Check if the error message is "Failure".
            if error.localizedDescription == "Failure" {
                // If it is, call the `handleNoInternetConnection` method on the `service` object.
                service.handleNoInternetConnection()
            }
            
        }
        
    }
    func getAllMeals() async {
        do {
            
            // Try to fetch the schools data from the API.
            meal = try await service.getAllDessertsService()
            
        } catch {
            // If there is an error, print the error message.
            print("Error can't return any data: \(error)")
            
            // Check if the error message is "Failure".
            if error.localizedDescription == "Failure" {
                // If it is, call the `handleNoInternetConnection` method on the `service` object.
                service.handleNoInternetConnection()
            }
            
        }
        
        
    }
    
    }
