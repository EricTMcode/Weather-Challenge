//
//  Endpoint.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

enum Endpoint {
    case weather(city: String)
}

extension Endpoint {
    enum MethodType {
        case GET
    }
}

extension Endpoint {
    var host: String { "api.weatherapi.com"}
    
    var path: String {
        switch self {
        case .weather:
            return "/v1/current.json"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .weather:
            return .GET
        }
    }
    
    var queryItems: [String: String] {
        switch self {
        case .weather(let city):
            return ["q":"\(city)"]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        let staticQueryItems = [URLQueryItem(name: "key", value: "d2ec8535bd3844b5b1d130828231309")]
        
        let requestQueryItems = queryItems.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        urlComponents.queryItems = requestQueryItems + staticQueryItems
        
        return urlComponents.url
    }
}
