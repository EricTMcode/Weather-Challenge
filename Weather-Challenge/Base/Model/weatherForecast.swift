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
    
    var isNight: Bool {
        return current.isNightBool
    }
    
    var tempText: Int {
        Int(current.tempC)
    }
    
    var iconText: String {
        if isNight {
            return current.condition.iconNightText
        } else {
            return current.condition.iconDayText
        }
    }
    
    var forecastIconText: String {
        return current.condition.iconDayText
    }
}

struct Location: Codable {
    let name, region, country: String
}

struct Current: Codable {
    let tempC: Double
    let isDay: Int
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
    }
    
    var isNightBool: Bool {
        switch isDay {
        case 0:
            return true
        default:
            return false
        }
    }
}

struct Condition: Codable, Hashable {
    let code: Int
    let text: String
    
    var iconDayText: String {
        return WeatherIconsDaytime[code] ?? "N/A"
    }
    
    var iconNightText: String {
        return WeatherIconsNighttime[code] ?? "N/A"
    }
}

struct Forecast: Codable {
    let forecastDay: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastDay = "forecastday"
    }
    
    var maxTempDayText: Int {
        return forecastDay.first?.maxDayTempText ?? 0
    }
    
    var minTempDayText: Int {
        return forecastDay.first?.minDayTempText ?? 0
    }
}

struct ForecastDay: Codable, Hashable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static let timeFormatter: DateFormatter = {
       let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return timeFormatter
    }()
    
    var dateText: String {
        let date = ForecastDay.dateFormatter.date(from: date)
        return date!.formatted(.dateTime.weekday(.abbreviated))
    }
    
    var dayText: String {
        let date = ForecastDay.dateFormatter.date(from: date)
        return date!.formatted(.dateTime.day())
    }
    
    var maxDayTempText: Int {
        return Int(day.maxTempC.rounded())
    }
    
    var minDayTempText: Int {
        return Int(day.minTempC.rounded())
    }
    
    var iconText: String {
        return day.condition.iconDayText
    }
    
}

struct Day: Codable, Hashable {
    let condition: Condition
    let maxTempC: Double
    let minTempC: Double
    
    enum CodingKeys: String, CodingKey {
        case condition
        case maxTempC = "maxtemp_c"
        case minTempC = "mintemp_c"
    }
}

struct Hour: Codable, Hashable {
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
    }
    
    var timeText: String {
        let time = ForecastDay.timeFormatter.date(from: time)
        return time!.formatted(.dateTime.hour())
    }
}
