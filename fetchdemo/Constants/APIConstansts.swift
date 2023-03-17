//
//  APIConstansts.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/10/23.
//

import Foundation


protocol URLComposition {
    var scheme: String              { get }
    
    
    var host:   String              { get }
    
    
    var path:   String              { get }
    
    
    var queryItems: [URLQueryItem]  { get }
}



enum Category: String {
    case dessert = "Dessert"
}

enum APIConstants: URLComposition {
    case getDesserts(category: Category)
    case getDessertsDetails(id: Int)

    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .getDesserts:
            return "/api/json/v1/1/filter.php"
        case .getDessertsDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getDesserts(let category):
            return [URLQueryItem(name: "c", value: category.rawValue)]
        case .getDessertsDetails(id: let id):
            return [URLQueryItem(name: "i", value: String(id))]
        }
    }
}

