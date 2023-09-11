//
//  Weather_ChallengeApp.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import SwiftUI

@main
struct Weather_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(lat: 37.32, lon: -122.03)
        }
    }
}
