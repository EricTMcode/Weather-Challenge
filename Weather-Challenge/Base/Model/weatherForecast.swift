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

struct Condition: Codable, Hashable {
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
        case "Partly cloudy":
            return "cloud.sun.fill"
        case "Moderate rain":
            return "cloud.rain.fill"
        case "Heavy rain":
            return "cloud.heavyrain.fill"
        case "Overcast":
            return "cloud.fill"
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
    let day: Day
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-mm-dd"
        return dateFormatter
    }()
    
    var dateText: String {
        let date = Forecastday.dateFormatter.date(from: date)
        return date!.formatted(.dateTime.weekday(.abbreviated))
    }
}

struct Day: Codable, Hashable {
//    let maxtempC, mintempC: Double
    let condition: Condition
    
    enum CondingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}
