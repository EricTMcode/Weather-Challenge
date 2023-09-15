//
//  ContentView.swift
//  Weather-Challenge
//
//  Created by Eric on 11/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeatherView(city: "Lyon")
                .tabItem {
                    Label("Lyon", systemImage: "sun.max.fill")
                }
            WeatherView(city: "Brisbane")
                .tabItem {
                    Label("Brisbane", systemImage: "moon.fill")
                }
            WeatherView(city: "London")
                .tabItem {
                    Label("London", systemImage: "cloud.heavyrain.fill")
                }
            WeatherView(city: "Tokyo")
                .tabItem {
                    Label("Tokyo", systemImage: "snow")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
