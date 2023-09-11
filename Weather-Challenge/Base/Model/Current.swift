//
//  Current.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import Foundation

struct Current: Codable {
    let id: Int
    let name: String
    let weather: [Weather]
    let sys: Sys
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    var iconImage: String {
        mapIcons(icon: icon)
    }
    
    func mapIcons(icon: String) -> String {
        switch icon {
        case "01d":
            return "sun.max.fill"
        case "01n":
            return "moon.fill"
        case "02d":
            return "cloud.sun.fill"
        case "02n":
            return "cloud.moon.fill"
        case "03d", "03n":
            return "cloud.fill"
        case "04d", "04m":
            return "smoke.fill"
        case "09d", "09n":
            return "cloud.heavyrain.fill"
        case "10d":
            return "cloud.sun.rain.fill"
        case "10n":
            return "cloud.moon.rain.fill"
        case "11d", "11n":
            return "cloud.bolt.fill"
        case "13d", "13n":
            return "snow"
        case "50d", "50n":
            return "wind"
        default:
            return "n/a"
        }
    }
}

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    var tempText: Int {
        return Int(temp.rounded())
    }
}
