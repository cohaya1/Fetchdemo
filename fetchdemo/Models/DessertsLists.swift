//
//  FetchModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import Foundation

struct DessertsLists<T:Codable>: Codable {
    var meals: T
}




struct Meal: Codable, Equatable, Hashable {
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    
    init(strMeal: String, strMealThumb: String, idMeal: String) {
            self.strMeal = strMeal
            self.strMealThumb = strMealThumb
            self.idMeal = idMeal
        }
    enum CodingKeys: String, CodingKey {
           case strMeal = "strMeal"
           case strMealThumb = "strMealThumb"
           case idMeal = "idMeal"
       }
}

extension Meal {
    static let sample = Self.init(strMeal: "Food", strMealThumb: "www.blah.com", idMeal: "23456")
}
