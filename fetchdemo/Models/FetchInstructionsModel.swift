//
//  FetchInstructionsModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/11/23.
//

import Foundation

struct RecipeMeals: Codable, Equatable {
    static func == (lhs: RecipeMeals, rhs: RecipeMeals) -> Bool {
            return lhs.recipes == rhs.recipes
        }
    var recipes: [Recipe] = []

    enum CodingKeys: String, CodingKey {
        case recipes
    }

   

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipes, forKey: .recipes)
    }
}



struct Recipe: Codable, Equatable {
    var idMeal                      : String? = nil
    var strMeal                     : String? = nil
    var strInstructions             : String? = nil
    var strMealThumb                : String? = nil
    var strIngredient1              : String? = nil
    var strIngredient2              : String? = nil
    var strIngredient3              : String? = nil
    var strIngredient4              : String? = nil
    var strIngredient5              : String? = nil
    var strIngredient6              : String? = nil
    var strIngredient7              : String? = nil
    var strIngredient8              : String? = nil
    var strIngredient9              : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case idMeal                      = "idMeal"
        case strMeal                     = "strMeal"
        case strInstructions             = "strInstructions"
        case strMealThumb                = "strMealThumb"
        case strIngredient1              = "strIngredient1"
        case strIngredient2              = "strIngredient2"
        case strIngredient3              = "strIngredient3"
        case strIngredient4              = "strIngredient4"
        case strIngredient5              = "strIngredient5"
        case strIngredient6              = "strIngredient6"
        case strIngredient7              = "strIngredient7"
        case strIngredient8              = "strIngredient8"
        case strIngredient9              = "strIngredient9"
        
    }
    
}
