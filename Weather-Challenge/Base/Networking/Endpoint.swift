//
//  Endpoint.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

enum Endpoint {
    case weather(lat: Double, lon: Double)
}

extension Endpoint {
    enum MethodType {
        case GET
    }
}

extension Endpoint {
    var host: String { "api.openweathermap.org "}
    
    var path: String {
        switch self {
        case .weather:
            return "/data/2.5/weather"
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
        case .weather(let lat, let lon):
            return ["lat":"\(lat)", "lon": "\(lon)"]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        let staticQueryItems = [URLQueryItem(name: "appid", value: "fd6e851964b08e0568183d2a7c65793b"),
                                URLQueryItem(name: "units", value: "metric")]
        
        let requestQueryItems = queryItems.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        urlComponents.queryItems = requestQueryItems + staticQueryItems
        
        return urlComponents.url
    }
}
