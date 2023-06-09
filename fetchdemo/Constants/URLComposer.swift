//
//  URLComposer.swift
//  fetchdemo
//
//  Created by Chika Ohaya on 3/15/23.
//

import Foundation


struct UrlComposer {
    var session: URLSession
    
    // uses dependency injection to allow for testability and modularity
    init(with session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func makeRequest<T: Codable>(at url: URL) async throws -> T {
        let (data, _) = try await session.data(from: url)
        
        // custom request
        do {
            let responseObject = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        } catch {
            throw StatusCodes.decodingError.localizedDescription
        }
       
    }
    
    func getURL(for endpoint: URLComposition) -> URL? {
        var urlComponent = URLComponents()
        urlComponent.host = endpoint.host
        urlComponent.scheme = endpoint.scheme
        urlComponent.path = endpoint.path
        urlComponent.queryItems = endpoint.queryItems
        return urlComponent.url
    }
}
