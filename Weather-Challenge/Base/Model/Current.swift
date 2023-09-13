//
//  Current.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

struct Current: Codable {
    let location: Location
    let current: CurrentClass
}

struct Location: Codable {
    let name, region, country: String
}

struct CurrentClass: Codable {
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
        case "Moderate or heavy rain with thunder":
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
    
    
}
