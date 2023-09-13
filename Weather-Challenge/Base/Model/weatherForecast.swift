//
//  Current.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

struct weatherForecast: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Codable {
    let name, region, country: String
}

struct Current: Codable {
    let tempC: Int
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

struct Condition: Codable {
    let code: Int
    let text: String
    
    var iconText: String {
        mapIcons(icon: text)
    }
    
    func mapIcons(icon: String) -> String {
        switch text {
        case "Sunny":
            return "sun.max.fill"
        case "Clear":
            return "moon.fill"
        case "Moderate or heavy rain with thunder":
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
}

struct Forecast: Codable {
    let forecastDay: [Forecastday]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
}

struct Forecastday: Codable, Hashable {
    let date: String
}

struct Day: Codable {
    let maxtempC, mintempC: Double
    let condition: Condition
    
    enum CondingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}
