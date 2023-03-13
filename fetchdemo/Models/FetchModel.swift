//
//  FetchModel.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import Foundation
struct DessertLists: Codable, RandomAccessCollection, Hashable, Equatable {
    static func == (lhs: DessertLists, rhs: DessertLists) -> Bool {
            return lhs.meals == rhs.meals
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(meals)
        }
    
    
   
    
    
    
    
    var meals: [Meal] = []
    
    // Implement the required properties for RandomAccessCollection
    // Implement the required properties for RandomAccessCollection
        
        typealias Element = Meal
        typealias Index = Array<Meal>.Index
        typealias SubSequence = Array<Meal>.SubSequence
        
        var startIndex: Index { meals.startIndex }
        var endIndex: Index { meals.endIndex }
        subscript(position: Index) -> Meal { meals[position] }
        subscript(bounds: Range<Index>) -> SubSequence { meals[bounds] }
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
    
    
    public func meal(at index: Int) -> Meal? {
            guard index >= 0 && index < meals.count else {
                return nil
            }
            return meals[index]
        }
        
        public subscript(index: Int) -> Meal? {
            return meal(at: index)
        }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(meals, forKey: .meals)
    }
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
